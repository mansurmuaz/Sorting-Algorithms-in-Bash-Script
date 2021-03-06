#!/bin/bash

for (( i = 2; i < 7; i++ )); do
    (( x = 10 ** $i ))
    awk -v n=$x -v seed="$RANDOM" 'BEGIN { srand(seed); for (i=0; i<n; ++i) printf("%.2f\n", rand()*1000) }' > RealNumber_$x.txt
    awk -v n=$x -v max=1000 'BEGIN{srand(); for (i=0; i<n; ++i) print int(rand()*(max+1))}' > Integer_$x.txt
    awk -v n=$x -v seed="$RANDOM" 'BEGIN { srand(seed); for (i=0; i<n; ++i) printf("%.4f\n", rand()) }' > RealNumber_0-1_$x.txt
done


for (( i = 6; i > 1; i-- )); do

    case $i in
        5)

            start_time="$(date -u +%s.%N)"
            ./bash_sort.sh -f Integer_100.txt -a $i
            end_time="$(date -u +%s.%N)"

            elapsed="$(bc <<<"$end_time-$start_time")"
            echo "Total of $elapsed seconds elapsed for $i with Integer_100"

            echo "----------------------"
        ;;
        6)

            start_time="$(date -u +%s.%N)"
            ./bash_sort.sh -f RealNumber_0-1_100.txt -a $i
            end_time="$(date -u +%s.%N)"

            elapsed="$(bc <<<"$end_time-$start_time")"
            echo "Total of $elapsed seconds elapsed for $i with RealNumber_0-1_100"

            echo "----------------------"

        ;;
        *)

            start_time="$(date -u +%s.%N)"
            ./bash_sort.sh -f RealNumber_100.txt -a $i
            end_time="$(date -u +%s.%N)"

            elapsed="$(bc <<<"$end_time-$start_time")"
            echo "Total of $elapsed seconds elapsed for $i with RealNumber_100"

            echo "----------------------"

        ;;
    esac
done

echo "--------------------------------------------------"


for (( i = 6; i > 1; i-- )); do

    case $i in
        5)

            start_time="$(date -u +%s.%N)"
            ./bash_sort.sh -f Integer_1000.txt -a $i
            end_time="$(date -u +%s.%N)"

            elapsed="$(bc <<<"$end_time-$start_time")"
            echo "Total of $elapsed seconds elapsed for $i with Integer_1000"

            echo "----------------------"
        ;;
        6)

            start_time="$(date -u +%s.%N)"
            ./bash_sort.sh -f RealNumber_0-1_1000.txt -a $i
            end_time="$(date -u +%s.%N)"

            elapsed="$(bc <<<"$end_time-$start_time")"
            echo "Total of $elapsed seconds elapsed for $i with RealNumber_0-1_1000"

            echo "----------------------"

        ;;
        *)

            start_time="$(date -u +%s.%N)"
            ./bash_sort.sh -f RealNumber_1000.txt -a $i
            end_time="$(date -u +%s.%N)"

            elapsed="$(bc <<<"$end_time-$start_time")"
            echo "Total of $elapsed seconds elapsed for $i with RealNumber_1000"

            echo "----------------------"

        ;;
    esac
done

echo "--------------------------------------------------"



for (( i = 6; i > 1; i-- )); do
    case $i in
        5)
            start_time="$(date -u +%s.%N)"
            ./bash_sort.sh -f Integer_10000.txt -a $i
            end_time="$(date -u +%s.%N)"

            elapsed="$(bc <<<"$end_time-$start_time")"
            echo "Total of $elapsed seconds elapsed for $i with Integer_10000"

            echo "----------------------" ;;
        6) start_time="$(date -u +%s.%N)"
            ./bash_sort.sh -f RealNumber_0-1_10000.txt -a $i
            end_time="$(date -u +%s.%N)"

            elapsed="$(bc <<<"$end_time-$start_time")"
            echo "Total of $elapsed seconds elapsed for $i with RealNumber_0-1_10000"

            echo "----------------------" ;;
        *) start_time="$(date -u +%s.%N)"
            ./bash_sort.sh -f RealNumber_10000.txt -a $i
            end_time="$(date -u +%s.%N)"

            elapsed="$(bc <<<"$end_time-$start_time")"
            echo "Total of $elapsed seconds elapsed for $i with RealNumber_10000"

            echo "----------------------" ;;
    esac
done

echo "--------------------------------------------------"


for (( i = 6; i > 1; i-- )); do

    case $i in
        5)

            start_time="$(date -u +%s.%N)"
            ./bash_sort.sh -f Integer_100000.txt -a $i
            end_time="$(date -u +%s.%N)"

            elapsed="$(bc <<<"$end_time-$start_time")"
            echo "Total of $elapsed seconds elapsed for $i with Integer_100000"

            echo "----------------------"
        ;;
        6)

            start_time="$(date -u +%s.%N)"
            ./bash_sort.sh -f RealNumber_0-1_100000.txt -a $i
            end_time="$(date -u +%s.%N)"

            elapsed="$(bc <<<"$end_time-$start_time")"
            echo "Total of $elapsed seconds elapsed for $i with RealNumber_0-1_100000"

            echo "----------------------"

        ;;
        *)

            start_time="$(date -u +%s.%N)"
            ./bash_sort.sh -f RealNumber_100000.txt -a $i
            end_time="$(date -u +%s.%N)"

            elapsed="$(bc <<<"$end_time-$start_time")"
            echo "Total of $elapsed seconds elapsed for $i with RealNumber_100000"

            echo "----------------------"

        ;;
    esac
done


echo "--------------------------------------------------"


for (( i = 6; i > 1; i-- )); do

    case $i in
        5)

            start_time="$(date -u +%s.%N)"
            ./bash_sort.sh -f Integer_1000000.txt -a $i
            end_time="$(date -u +%s.%N)"

            elapsed="$(bc <<<"$end_time-$start_time")"
            echo "Total of $elapsed seconds elapsed for $i with Integer_1000000"

            echo "----------------------"
        ;;
        6)

            start_time="$(date -u +%s.%N)"
            ./bash_sort.sh -f RealNumber_0-1_1000000.txt -a $i
            end_time="$(date -u +%s.%N)"

            elapsed="$(bc <<<"$end_time-$start_time")"
            echo "Total of $elapsed seconds elapsed for $i with RealNumber_0-1_1000000"

            echo "----------------------"

        ;;
        *)

            start_time="$(date -u +%s.%N)"
            ./bash_sort.sh -f RealNumber_1000000.txt -a $i
            end_time="$(date -u +%s.%N)"

            elapsed="$(bc <<<"$end_time-$start_time")"
            echo "Total of $elapsed seconds elapsed for $i with RealNumber_1000000"

            echo "----------------------"

        ;;
    esac
done


echo "--------------------------------------------------"


start_time="$(date -u +%s.%N)"
./bash_sort.sh -f RealNumber_100.txt -a $i
end_time="$(date -u +%s.%N)"

elapsed="$(bc <<<"$end_time-$start_time")"
echo "Total of $elapsed seconds elapsed for 1 with RealNumber_100"

echo "----------------------"


start_time="$(date -u +%s.%N)"
./bash_sort.sh -f RealNumber_1000.txt -a $i
end_time="$(date -u +%s.%N)"

elapsed="$(bc <<<"$end_time-$start_time")"
echo "Total of $elapsed seconds elapsed for 1 with RealNumber_1000"

echo "----------------------"


start_time="$(date -u +%s.%N)"
./bash_sort.sh -f RealNumber_10000.txt -a $i
end_time="$(date -u +%s.%N)"

elapsed="$(bc <<<"$end_time-$start_time")"
echo "Total of $elapsed seconds elapsed for 1 with RealNumber_10000"

echo "----------------------"


start_time="$(date -u +%s.%N)"
./bash_sort.sh -f RealNumber_100000.txt -a $i
end_time="$(date -u +%s.%N)"

elapsed="$(bc <<<"$end_time-$start_time")"
echo "Total of $elapsed seconds elapsed for 1 with RealNumber_100000"

echo "----------------------"



start_time="$(date -u +%s.%N)"
./bash_sort.sh -f RealNumber_1000000.txt -a $i
end_time="$(date -u +%s.%N)"

elapsed="$(bc <<<"$end_time-$start_time")"
echo "Total of $elapsed seconds elapsed for 1 with RealNumber_1000000"

echo "----------------------"
