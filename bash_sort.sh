#!/bin/bash

# awk -v n=10 -v seed="$RANDOM" 'BEGIN { srand(seed); for (i=0; i<n; ++i) printf("%.2f\n", rand()*1000) }' > randomRealNumbers.txt
# awk -v n=20 -v max=100 'BEGIN{srand(); for (i=0; i<n; ++i) print int(rand()*(max+1))}' > randomIntegers.txt
# awk -v n=20 -v seed="$RANDOM" 'BEGIN { srand(seed); for (i=0; i<n; ++i) printf("%.4f\n", rand()) }' > randomRealNumbers0-1.txt

printArray() {
    arr=("$@")

    for i in "${arr[@]}"; do
        echo "$i"
    done
}

writeSortedArray() {
    arr=("$@")
    printf "%s\n" "${arr[@]}" > sorted.txt
}

#===============================================================================

insertionSort() {

    arr=("$@")
    n=${#arr[@]}

    for((i=1;i<n;i++)) ; do
        j=$i-1
        temp=${arr[$i]}

        while [[ $j -ge 0 && 1 -eq `echo "${arr[$j]} > $temp" | bc` ]]; do
            arr[$j+1]=${arr[$j]}
            j=$((j-1))
        done
        arr[j+1]=$temp
    done

    printf "%s\n" "${arr[@]}"
}

#===============================================================================

merge() {
	left=2
	(( right = $1 + 2 ))
	for i in ${@:2} ; do
		if [[ $left -eq $(( $1 + 2 )) ]] ; then
			echo ${@:$right:1}
            ((right += 1))
		else
			if [[ $right -eq $(( ${#@} + 1 )) ]] ; then
				echo ${@:$left:1}
                ((left += 1))
			else
				if (( $(echo "${@:$left:1} < ${@:$right:1}" | bc -l) )) ; then
					echo ${@:$left:1}
                    ((left += 1))
				else
					echo ${@:$right:1}
                    ((right += 1))
				fi
			fi
		fi
	done
}

mergeSort() {
    n=$1
	if [[ $n -ge 2 ]] ; then
		(( mid = $n / 2 ))
		left=( $(mergeSort $mid ${@:2:$mid}) )
		right=( $(mergeSort $(( $n - $mid )) ${@:$(( $mid + 2 )):$(( $n - $mid ))}) )
		echo "$(merge $mid ${left[@]} ${right[@]})"
	else
		echo $2
    fi
}

#===============================================================================

buildMaxHeap() {
    n=$1
    arr=("${@:2}")

    for (( i = 1; i < $n; i++ )); do

        if [[ 1 -eq `echo "${arr[$i]} > ${arr[$(( ( $i - 1 ) / 2 ))]}" | bc` ]]; then
            j=$i

            while [[ 1 -eq `echo "${arr[$j]} > ${arr[$(( ( $j - 1 ) / 2 ))]}" | bc` ]]; do

                tmp=${arr[j]}
                arr[j]=${arr[$(( ( $j - 1 ) / 2 ))]}
                arr[$(( ( $j - 1 ) / 2 ))]=$tmp

                (( j = ( $j - 1 ) / 2 ))
            done
        fi
    done

    echo "${arr[@]}"
}

heapSort() {

    arr=("${@:2}")
    n=${#arr[@]}

    arr=( $(buildMaxHeap $n "${arr[@]}") )

    for (( i = $(( $n - 1 )); i > 0; i-- )); do

        tmp=${arr[0]}
        arr[0]=${arr[i]}
        arr[i]=$tmp

        j=0
        index=0

        while :
        do

            (( index = 2 * $j + 1 ))

            if [[ $index -lt $(( $i - 1 )) && 1 -eq `echo "${arr[$index]} < ${arr[$(( $index + 1 ))]}" | bc` ]]; then
                (( index = $index + 1 ))
            fi

            if [[ $index -lt $i && 1 -eq `echo "${arr[$j]} < ${arr[$index]}" | bc` ]]; then
                tmp=${arr[j]}
                arr[j]=${arr[index]}
                arr[index]=$tmp
            fi

            j=$index

            if [[ $index -ge $i ]]; then
                break
            fi
        done
    done

    writeSortedArray "${arr[@]}"
}

#===============================================================================

partition() {

    l=$l
    h=$h
    arr=("${@:3}")

    (( i = $l - 1 ))
    x=${arr[$h]}

    for (( j = $l; j < $h; j++ )); do

        if [[ 1 -eq `echo "${arr[$j]} <= $x" | bc` ]]; then

            # increment index of smaller element
            ((i += 1))
            tmp=${arr[j]}
            arr[j]=${arr[i]}
            arr[i]=$tmp

        fi
    done

    tmp=${arr[h]}
    arr[h]=${arr[$(( $i + 1 ))]}
    arr[$(( $i + 1 ))]=$tmp

    ((i += 1))
    arr+=( $i )
    echo "${arr[@]}"
}

quickSort() {

    arr=("${@:2}")
    l=0
    (( h = $1 - 1 ))

    # Create an auxiliary stack
    (( size = $h - $l + 1 ))
    for (( i = 0; i < $size ; i++ )); do
        stack+=(0)
    done

    # initialize top of stack
    top=-1
    # push initial values of l and h to stack

    ((top += 1))
    stack[$top]=$l
    ((top += 1))
    stack[$top]=$h

    # Keep popping from stack while is not empty

    while(( $top>=0 )) ; do

        h=${stack[$top]}
        ((top -= 1))
        l=${stack[$top]}
        ((top -= 1))

        # Set pivot element at its correct position in
        # sorted array
        temp=( $( partition $l $h "${arr[@]}" ) )
        # echo "${temp[@]}"
        p=${temp[${#temp[@]}-1]}
        arr=( "${temp[@]:0:$size}" )

        # If there are elements on left side of pivot,
        # then push left side to stack
        if [[ $l -lt $(( $p - 1 )) ]]; then
            ((top += 1))
            stack[$top]=$l
            ((top += 1))
            stack[$top]=$(( $p - 1 ))
        fi

        # If there are elements on right side of pivot,
        # then push right side to stack
        if [[ $h -gt $(( $p + 1 )) ]]; then
            ((top += 1))
            stack[$top]=$(( $p + 1 ))
            ((top += 1))
            stack[$top]=$h
        fi

    done

    writeSortedArray "${arr[@]}"
}

#===============================================================================

countingSort() {

    arr=("${@:2}")
    n=${#arr[@]}
    max=1000
    (( m = $max + 1 ))

    for (( i = 0; i < $m ; i++ )); do
        count+=(0)
    done

    for i in "${arr[@]}" ; do

        (( count[$i]++ ))
    done

    i=0
    for (( a = 0; a < $m; a++ )); do
        for (( c = 0; c < "${count[$a]}"; c++ )); do
            arr[$i]=$a
            (( i++ ))
        done
    done

    writeSortedArray "${arr[@]}"
}

#===============================================================================

bucketSort() {

    n=$1
    arr=("${@:2}")

    slotNum=1000
    (( slot = $slotNum - 1 ))
    eval rm -rf tempFiles
    eval mkdir tempFiles
    eval touch tempFiles/file.{0..$slot}.txt

    for j in "${arr[@]}" ; do
        floatIndex=`echo "$j * $slotNum" | bc | awk '{printf "%f", $0}'`
        index=${floatIndex%.*}
        printf "%s\n" $j >> tempFiles/file.$index.txt
    done


    for (( i = 0; i < $slotNum; i++ )); do
        tempArray=()
        while IFS='' read -r line || [[ -n "$line" ]]; do
            tempArray+=( "$line" )
        done < "tempFiles/file.$i.txt"

        insertionSort "${tempArray[@]}" > tempFiles/file.$i.txt &
        wait
    done

    eval touch sorted.txt
    for (( i = 0; i < $slotNum; i++ )); do
        cat tempFiles/file.$i.txt >> sorted.txt
    done

    eval rm -rf tempFiles
}

#===============================================================================

printUsageStatement() {

    echo "  ./bash_sort: missing argument.
        Usage: ./bash_sort –f | --filename <input filename> -a | --algorithm <sorting algorithm> [-h | --help]
        Try './bash_sort --help' for more information."
}

printUsageStatement2() {

    echo "  ./bash_sort: wrong argument or missing file.
        Usage: ./bash_sort –f | --filename <input filename> -a | --algorithm <sorting algorithm> [-h | --help]
        Try './bash_sort --help' for more information."
}

#===============================================================================

if [[ "$#" -ne 4 ]]; then
    if [[ ( "$#" -eq 1 )  && ( ( $1 = "-h" ) || ( $1 = "--help") ) ]] ; then
        cat help.txt
    else
        printUsageStatement
    fi
else
    # Check $1 is -f or --filename and $2 is exist and readable file.
    if [[ (( $1 = "-f" ) || ( $1 = "--filename")) && (-n $2 && -r $2) ]] ; then

        # Check 3 is -a or --algorithm and $4 is integer between 1 - 6
        if [[ (( $3 = "-a" ) || ( $3 = "--algorithm")) && ( "$4" =~ ^[1-6]$ ) ]] ; then

            # Add inputs to array
            while IFS='' read -r line || [[ -n "$line" ]]; do
                numbersArray+=( "$line" )
            done < "$2"

            n=${#numbersArray[@]}

            case $4 in
                1) insertionSort "${numbersArray[@]}" > sorted.txt ;;
                2) mergeSort $n "${numbersArray[@]}" > sorted.txt ;;
                3) heapSort $n "${numbersArray[@]}" ;;
                4) quickSort $n "${numbersArray[@]}" ;;
                5) countingSort $n "${numbersArray[@]}" ;;
                6) bucketSort "${numbersArray[@]}" ;;
            esac
        else
            printUsageStatement2
        fi
    else
        printUsageStatement2
    fi
fi
