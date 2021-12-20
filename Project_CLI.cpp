#include <mysql/mysql.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>
#include <iostream>

using namespace std;

int main(const int argc, const char *argv[])
{

    const char *USERID = "i6wu"; // Your UserID here
    const char *SERVER = "marmoset02.shoshin.uwaterloo.ca";
    const char *DBNAME = ""; // Can specify a database; don't want to
    const char *QUERY = "select schema_name from information_schema.schemata order by schema_name";

    MYSQL mysql;            // Space for handler
    MYSQL *pMysql = &mysql; // Pointer to handler

    const int bufLen = 256;

    MYSQL_RES *pQueryResult; // Pointer to query result handler
    MYSQL_ROW row;           // Space for result row
    int numFields;           // Number of fields in query

    // Attempt DB connection
    // Get a handler first

    if (!mysql_init(pMysql))
    {
        cerr << ": mysql_init() error: insufficient memory" << endl;
        return -1 * ENOMEM;
    }

    // Prompt for a password and connect (use default port 3306)
    const char *passwd = getpass("Password: ");
    if (!mysql_real_connect(pMysql,
                            SERVER,
                            USERID,
                            passwd,
                            DBNAME,
                            0,    // Use default port (3306)
                            NULL, // Not using unix socket or named pipe
                            0))
    { // No client flags
        cerr << ": mysql_real_connect() error: " << mysql_error(pMysql) << endl;
        return -1;
    }

    bool exit = false;
    // Now we need to do the query.  The specific query depends on the options or
    // lack of options.
    while (!exit)
    {
        string input;
        cout << " Type a valid sql command, or type 'exit' to quit: " <<endl;
        cin >> input;
        if (input == "exit") {
            exit = true;
            cout << "Exiting..." << endl;
            break;
        }

        const char *baseQuery = input.c_str();

        int queryLen = strlen(baseQuery) +
                       1; // Needed for null terminator

        // Allocate the query buffer
        char queryBuffer[queryLen];

        // Copy the query into the query buffer
        strcpy(queryBuffer, baseQuery);

        // Run the query
        int rc = mysql_query(pMysql, queryBuffer);
        if (rc)
        {
            cerr << ": mysql_query() error: " << mysql_error(pMysql) << endl
                 << "rc: " << rc << endl;
            return -1;
        }

        // Fetch the results
        pQueryResult = mysql_store_result(pMysql);
        numFields = mysql_field_count(pMysql); // And get the field count
        if (!pQueryResult)
        { // We got nothing back; that may be OK
            cout << "!pQueryResult" << endl;
            if (numFields == 0)
            { // We should have nothing back!
                cerr << argv[0] << ": Information: Query \"" << QUERY << "\" returned zero rows" << endl;
            }
            else
            {
                cerr << argv[0] << ": Error: Query \"" << QUERY << "\" failed to return expected data" << endl
                     << argv[0] << ": error information: " << mysql_error(pMysql) << endl;
                return -1;
            }
        }
        else
        { // Retrieve the rows
            cout << "Database";
            cout << endl
                 << "--------------" << endl;
            while ((row = mysql_fetch_row(pQueryResult)))
            {
                unsigned long *lengths;
                lengths = mysql_fetch_lengths(pQueryResult);
                for (int i = 0; i < numFields; i++)
                    printf("%.*s ", (int)lengths[i], row[i] ? row[i] : "NULL");
                printf("\n");
            }
            cout << "--------------" << endl;
        }
        mysql_free_result(pQueryResult);
        mysql_close(pMysql);
    }

    return 0;
}