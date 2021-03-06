#!/usr/bin/bash

function pacman-last-used {

    storage_dir=${HOME}/.config/pacman-last
    mkdir -p $storage_dir
    
    unsorted=$storage_dir/"packages.1.exec_bins.log"
    sorted=$storage_dir/"packages.2.exec_bins.sorted"
    sorted_packs=`mktemp` #"3.packages.sorted"
    sorted_packs_flat=$storage_dir/"packages.3.first_last_usage"
    sorted_packs_last=$storage_dir/"packages.4.last_usage_grouped_by_date"


    cmd_package_ownership=""
    cmd_package_name=""


    function setOSspecifics {
      local os=$(uname -r | awk -F'-' '{print $NF}')

      case $os in
          ARCH)
        cmd_package_ownership='pacman -Qo';
        cmd_package_name='sed -r "s|^.+is owned by (.*)\s.+|\1|"';
        ;;
         MANJARO)
        cmd_package_ownership='pacman -Qo';
        cmd_package_name='sed -r "s|^.+is owned by (.*)\s.+|\1|"';
        ;;

          # TODO: others
      esac

      if [ "$cmd_package_ownership" = "" ] || [ "$cmd_package_name" = "" ];then
          echo "Compatible OS not detected."
          exit -1
      fi	
    }


    function calc_packages {

      if [ -e $unsorted ]; then
          echo -n " [Info] $unsorted already exists. Overwrite [Y/n]? "; read ans
          [ "$ans" != "y" ] && echo " [Info] Using existing." && return 0
      fi

      # Otherwise proceed
      echo "" > $unsorted

      local width=$(stty size | cut -d" " -f 2)

      echo "      [Info] Checking:"

      for dir in `echo $PATH | sed "s|:| |g"`;
           #for dir in /usr/bin/core_perl
      do
          local num=$(ls $dir | wc -l)
          local count=0

          echo "             $dir"

          for bin in `ls $dir`; do
            count=$(( $count + 1))
            local full_path=$dir/$bin

            local last_used=$(stat -c %x $full_path)
            local owned_by=$(eval $cmd_package_ownership $full_path 2>&1 | eval $cmd_package_name)

            [ "`echo $owned_by | grep error`" != "" ] && owned_by="ERROR"

            local out="${last_used}\t${full_path}\t${owned_by}"

            echo -e "$out" >> $unsorted

            local line=$( printf "             (%4d / %4d) %30s -- %s" $count $num "$owned_by" "$full_path" )
            printf "\r%-${width}s" "$line"
          done
      done
    }



    function sanityCheck {
      file=$1
      message="$2"

      ! [ -e $file ] && echo "[Error] Cannot find $file. Terminating." && exit -1

      [ "$message" != "" ] && echo "$message"
    }


    setOSspecifics

    echo ""


    sanityCheck "" " - 1. Gathering info on all bins in PATH"
    calc_packages


    sanityCheck $unsorted " - 2. Sorting bins by package ownership and date"
    awk '{print $1"\t"$4"\t"$5}' $unsorted  | sort -k3 -k1n > $sorted


    sanityCheck $sorted " - 3. Sorting packages by first and last usage"
    awk -F'\t' '{print $3"\t"$1}' $sorted | uniq > $sorted_packs

    # Flatten lines of adjacent packages
    sanityCheck $sorted_packs ""
    awk -F'\t' 's != $1 || NR ==1{s=$1;if(p){print p};p=$0;next}{sub($1,"",$0);p=p""$0;}END{print p}' $sorted_packs\
	| awk -F"\t" '{print $1"\t"$2"\t"$NF}' > $sorted_packs_flat


    sanityCheck $sorted_packs_flat " - 4. Grouping packages by date (last usage)"
    sort -k3 $sorted_packs_flat\
	| awk -F'\t' '{print $3"\t"$1}'\
	| awk -F'\t' 's != $1 || NR ==1{s=$1;if(p){print p};p=$0;next}{sub($1,"",$1);p=p""$0;}END{print p}'\
	      > $sorted_packs_last

    echo ""

    echo " [Info] Files written:

   ->   $unsorted
   ->   $sorted
   ->   $sorted_packs_flat
   ->   $sorted_packs_last"

    echo ""
}

pacman-last-used
