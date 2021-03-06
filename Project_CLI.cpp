#include <mysql/mysql.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>
#include <iostream>

using namespace std;
string make_query(int count);
string add_query();
string modify_query();

int main(const int argc, const char *argv[])
{

    const char *USERID = "i6wu"; // Your UserID here
    const char *SERVER = "marmoset02.shoshin.uwaterloo.ca";
    const char *DBNAME = "db356_i6wu"; // Can specify a database; don't want to

    MYSQL mysql;            // Space for handler
    MYSQL *pMysql = &mysql; // Pointer to handler



    MYSQL_RES *pQueryResult; // Pointer to query result handler
    MYSQL_ROW row;           // Space for result row
    int numFields;           // Number of fields in query
    const char *passwd = getpass("Password: ");

    bool exit = false;
    while (!exit)
    {
        // Attempt DB connection
        // Get a handler first

        if (!mysql_init(pMysql))
        {
            cerr << ": mysql_init() error: insufficient memory" << endl;
            return -1 * ENOMEM;
        }

        // Prompt for a password and connect (use default port 3306)
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

        mysql_set_server_option(pMysql, MYSQL_OPTION_MULTI_STATEMENTS_ON);

        string input;
        string query = "";
        bool good_query = true;
        cout << "Would you like (A)dd, (M)odify or (Q)uery the database? Type 'exit' to quit: " << endl;
        getline(cin, input);
        if (input == "exit")
        {
            exit = true;
            cout << "Exiting..." << endl;
            break;
        }
        else if (input == "A" || input == "a")
        {
            // Code for adding
            query = add_query();
        }
        else if (input == "M" || input == "m")
        {
            // Code for modifying
            query = modify_query();
        }
        else if (input == "Q" || input == "q")
        {
            // Code for query
            int count = 0; // 1 list, 2 count
            cout << "Would you like a (L)ist or a (C)ount, or type 'exit' to quit: " << endl;
            getline(cin, input);
            if (input == "exit")
            {
                exit = true;
                cout << "Exiting..." << endl;
                good_query = false;
            }
            else if (input == "L" || input == "l")
            {
                count = 1;
            }
            else if (input == "C" || input == "c")
            {
                count = 2;
            }
            else
            {
                cout << input << " is not a valid command." << endl;
            }
            query = make_query(count);
        }
        else
        {
            cout << input << " is not a valid command." << endl;
            good_query = false;
        }

        if (query == "error")
        {
            good_query = false;
        }
        if (query == "exit")
        {
            good_query = false;
            exit = true;
            cout << "Exiting..." << endl;
        }
        if (good_query)
        {
            const char *baseQuery = query.c_str();

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
            }

            // Fetch the results
            pQueryResult = mysql_store_result(pMysql);
            numFields = mysql_field_count(pMysql); // And get the field count
            if (!pQueryResult)
            { // We got nothing back; that may be OK
                if (numFields == 0)
                { // We should have nothing back!
                    cout << ": Information: Query \"" << query << "\" returned zero rows" << endl;
                    cout << "Success!" <<endl;
                }
                else
                {
                    cerr << argv[0] << ": Error: Query \"" << query << "\" failed to return expected data" << endl
                         << argv[0] << ": error information: " << mysql_error(pMysql) << endl;
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
    }

    return 0;
}

/*
 Count: 1 = list, 2 = count
*/
string make_query(int count)
{
    string return_value = "";
    if (count == 1)
    {
        return_value = "SELECT stateCase, year from Accident INNER JOIN Date USING(stateCase) ";
    }
    else if (count == 2)
    {
        return_value = "SELECT COUNT(DISTINCT stateCase) from Accident ";
    }
    else
    {
        return "error";
    }

    string input = "";
    bool loop = true;
    string hold;
    while (loop)
    {
        cout << "Type a valid command, or type 'help' for a list of commands: " << endl;
        getline(cin, input);
        if (input == "help")
        {
            cout << "-1 : exit" << endl
                 << "1 : stateCase" << endl
                 << "2 : Date" << endl;
            cout << "3 : Location" << endl
                 << "4 : Person Count" << endl
                 << "5 : Speed Limit" << endl;
            cout << "6 : Drunk Driver" << endl
                 << "7 : Roll Over" << endl
                 << "8 : Hit and Run" << endl;
            cout << "9 : Weather" << endl
                 << "10 : Death Count" << endl;
        }
        else
        {
            loop = false;
        }
    }
    if (input == "-1") // exit
    {
        return_value = "exit";
    }
    else if (input == "1") // Case, State
    {
        cout << "Enter a state case number: " << endl;
        getline(cin, hold);
        return_value.append("WHERE stateCase = ");
        return_value.append(hold);
    }
    else if (input == "2") // Date
    {
        if (count == 2)
            return_value.append("INNER JOIN Date USING(stateCase) ");
        loop = true;
        while (loop)
        {
            cout << "(G)reater than, (L)ess than, or (E)qual, or type 'exit' to quit: " << endl;
            getline(cin, hold);
            if (hold == "G" || hold == "g" || hold == "L" || hold == "l" || hold == "E" || hold == "e")
            {
                loop = false;
            }
            if (hold == "exit")
            {
                loop = false;
                return_value = hold;
            }
        }
        if (hold == "G" || hold == "g") {
            return_value.append("WHERE year > ");
        }
        else if (hold == "L" || hold == "l") {
            return_value.append("WHERE year < ");
        }
        else if (hold == "E" || hold == "e") {
            return_value.append("WHERE year = ");
        }
        if (hold != "exit") {
            cout << "Enter a year: " << endl;
            getline(cin, hold);
            return_value.append(hold);
        }
    }
    else if (input == "3") // Location
    {
        cout << "Enter a stateID: " << endl;
        getline(cin, hold);
        return_value.append("WHERE state = ");
        return_value.append(hold);
    }
    else if (input == "4") // Persons count
    {
        loop = true;
        while (loop)
        {
            cout << "(G)reater than, (L)ess than, or (E)qual, or type 'exit' to quit: " << endl;
            getline(cin, hold);
            if (hold == "G" || hold == "g" || hold == "L" || hold == "l" || hold == "E" || hold == "e")
            {
                loop = false;
            }
            if (hold == "exit")
            {
                loop = false;
                return_value = hold;
            }
        }
        if (hold == "G" || hold == "g")
        {
            return_value.append("WHERE persons > ");
        }
        else if (hold == "L" || hold == "l")
        {
            return_value.append("WHERE persons < ");
        }
        else if (hold == "E" || hold == "e")
        {
            return_value.append("WHERE persons = ");
        }
        if (hold != "exit")
        {
            cout << "Enter a value for the person count: " << endl;
            getline(cin, hold);
            return_value.append(hold);
        }
    }
    else if (input == "5") // Speed Limit
    {
        return_value.append("INNER JOIN Vehicle USING(stateCase) ");
        loop = true;
        while (loop)
        {
            cout << "(G)reater than, (L)ess than, or (E)qual, or type 'exit' to quit: " << endl;
            getline(cin, hold);
            if (hold == "G" || hold == "g" || hold == "L" || hold == "l" || hold == "E" || hold == "e")
            {
                loop = false;
            }
            if (hold == "exit")
            {
                loop = false;
                return_value = hold;
            }
        }
        if (hold == "G" || hold == "g") {
            return_value.append("WHERE speedLimit > ");
        }
        else if (hold == "L" || hold == "l") {
            return_value.append("WHERE speedLimit < ");
        }
        else if (hold == "E" || hold == "e") {
            return_value.append("WHERE speedLimit = ");
        }
        if (hold != "exit") {
            cout << "Enter a speed limit: " << endl;
            getline(cin, hold);
            return_value.append(hold);
        }
    }
    else if (input == "6") // Drunk Driver
    {
        loop = true;
        while (loop)
        {
            cout << "(G)reater than, (L)ess than, or (E)qual, or type 'exit' to quit: " << endl;
            getline(cin, hold);
            if (hold == "G" || hold == "g" || hold == "L" || hold == "l" || hold == "E" || hold == "e")
            {
                loop = false;
            }
            if (hold == "exit")
            {
                loop = false;
                return_value = hold;
            }
        }
        if (hold == "G" || hold == "g")
        {
            return_value.append("WHERE drunkDrivers > ");
        }
        else if (hold == "L" || hold == "l")
        {
            return_value.append("WHERE drunkDrivers < ");
        }
        else if (hold == "E" || hold == "e")
        {
            return_value.append("WHERE drunkDrivers = ");
        }
        if (hold != "exit")
        {
            cout << "Enter a value for the drunk driver count: " << endl;
            getline(cin, hold);
            return_value.append(hold);
        }
    }
    else if (input == "7") // Roll Over
    {
        return_value.append("INNER JOIN Vehicle USING(stateCase) WHERE rollover = ");
        cout << "Rollover (y/n): " << endl;
        getline(cin, hold);
        if (hold == "y") {
            return_value.append("1");
        }
        if (hold == "n") {
            return_value.append("0");
        }
    }
    else if (input == "8") // Hit and Run
    {
        return_value.append("INNER JOIN Vehicle USING(stateCase) WHERE hitAndRun = ");
        cout << "Hit and run (y/n): " << endl;
        getline(cin, hold);
        if (hold == "y") {
            return_value.append("1");
        }
        if (hold == "n") {
            return_value.append("0");
        }
    }
    else if (input == "9") // Weather
    {
        cout << "Enter weather condition: " << endl;
        getline(cin, hold);
        return_value.append("WHERE weather = \"");
        return_value.append(hold);
        return_value.append("\"");
    }
    else if (input == "10") // Death Count
    {
        loop = true;
        while (loop)
        {
            cout << "(G)reater than, (L)ess than, or (E)qual, or type 'exit' to quit: " << endl;
            getline(cin, hold);
            if (hold == "G" || hold == "g" || hold == "L" || hold == "l" || hold == "E" || hold == "e")
            {
                loop = false;
            }
            if (hold == "exit")
            {
                loop = false;
                return_value = hold;
            }
        }
        if (hold == "G" || hold == "g")
        {
            return_value.append("WHERE fatalities > ");
        }
        else if (hold == "L" || hold == "l")
        {
            return_value.append("WHERE fatalities < ");
        }
        else if (hold == "E" || hold == "e")
        {
            return_value.append("WHERE fatalities = ");
        }
        if (hold != "exit")
        {
            cout << "Enter a value for the death count: " << endl;
            getline(cin, hold);
            return_value.append(hold);
        }
    }
    else
    {
        cout << input << " is not a valid command." << endl;
        return_value = "error";
    }

    if (return_value != "error" && return_value != "exit")
    {
        return_value.append(";");
    }

    return return_value;
}

string add_query()
{
    string return_value = "INSERT INTO Accident(stateCase) VALUES (";
    string input, hold;

    cout << "What is the state case number: " << endl;
    getline(cin, input);
    return_value.append(input);
    return_value.append("); ");
    cout << "What year did this occur: " << endl;
    getline(cin, hold);
    return_value.append("INSERT INTO Date(stateCase, year) VALUES (");
    return_value.append(input);
    return_value.append(", ");
    return_value.append(hold);
    return_value.append(");");

    return return_value;
}

string modify_query()
{
    string return_value = "UPDATE Accident SET ";
    string input, hold;

    cout << "What is the old state case number: " << endl;
    getline(cin, hold);
    cout << "What is the new state case number: " << endl;
    getline(cin, input);
    return_value.append("stateCase = ");
    return_value.append(input);
    return_value.append(" WHERE stateCase = ");
    return_value.append(hold);
    return_value.append("; UPDATE Date SET stateCase = ");
    return_value.append(input);
    return_value.append(" WHERE stateCase = ");
    return_value.append(hold);

    return return_value;
}
