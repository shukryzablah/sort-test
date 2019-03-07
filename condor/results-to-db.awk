#! /usr/bin/awk -f

BEGIN { FS = "," }
{
    {
	printf "INSERT INTO sorttimings ( algorithm, length, range_max, iteration, time, displacement ) VALUES (\"" $1 "\", " $2 ", " $3 ", " $4 ", " $5 ", " $6 " );\n"
    }
}
