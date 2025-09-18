#!/bin/bash
mysql -u MySQLUser -p < PlannerTaskScheduleDB.sql
protoPersonalPlanner -u MySQLUser -p MySQLPassword >& UnitTests/testOut.txt
mysql -u MySQLUser -p < PlannerTaskScheduleDB.sql
valgrind --track-origins=yes --suppressions=UnitTests/unitTestValgrindSuppressExpectedErrors.supp  protoPersonalPlanner -u MySQLUser -p MySQLPassword  2>&1 | sed 's/^==[0-9]*== //' > UnitTests/valgrindOut.txt
echo "Diff"
diff UnitTests/testOut.txt UnitTests/testOut_forDiff.txt
echo "valgrind Diff"
diff UnitTests/valgrindOut.txt UnitTests/valgrindOut_forDiff.txt
