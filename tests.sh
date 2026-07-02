#!/bin/bash

echo "Executing student's SQL..."

mysql -uroot -proot < solution.sql

echo "Checking Database..."

DB=$(mysql -uroot -proot -Nse "SHOW DATABASES LIKE 'CollegeDB';")

if [ "$DB" != "CollegeDB" ]; then
    echo "Database CollegeDB not found."
    exit 1
fi

echo "Checking Department Table..."

TABLE=$(mysql -uroot -proot -Nse "USE CollegeDB; SHOW TABLES LIKE 'Department';")

if [ "$TABLE" != "Department" ]; then
    echo "Department table not found."
    exit 1
fi

echo "Checking Columns..."

mysql -uroot -proot -e "USE CollegeDB; DESCRIBE Department;" > columns.txt

grep "DepartmentID" columns.txt
grep "DepartmentName" columns.txt
grep "HOD" columns.txt

echo "Checking Primary Key..."

PRIMARY=$(mysql -uroot -proot -Nse "
USE CollegeDB;
SHOW KEYS FROM Department WHERE Key_name='PRIMARY';
")

if [ -z "$PRIMARY" ]; then
    echo "Primary Key missing."
    exit 1
fi

echo "All Tests Passed."
