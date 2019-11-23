#/usr/bin/env bash
_odoo_Service_completions()
{
	
   if [ "${#COMP_WORDS[@]}" != "2" ]; then
      return
   fi

    COMPREPLY=($(compgen -W "start stop restart status" "${COMP_WORDS[1]}"))
}

complete -F _odoo_Service_completions odoo
