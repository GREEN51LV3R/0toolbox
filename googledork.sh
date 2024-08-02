#!/bin/bash

# check the input
if [-z "$1"]; then
    echo "Usage : $0 <domain / files>"
    exit 1
fi 

# perform google dorking

perform_dorking(){
    local DOMAIN="$1"
    echo "Performing google dorking for domain : $DOMAIN"

    # google dorks
    QUERIES=(
        "site:example.com ext:doc | ext:docx | ext:odt | ext:rtf | ext:sxw | ext:psw | ext:ppt | ext:pptx | ext:pps | ext:csv"
        "site:example.com intitle:index.of"
        "site:example.com ext:xml | ext:conf | ext:cnf | ext:reg | ext:inf | ext:rdp | ext:cfg | ext:txt | ext:ora | ext:ini | ext:env"
        "site:example.com ext:sql | ext:dbf | ext:mdb"
        "site:example.com ext:log"
        "site:example.com ext:bkf | ext:bkp | ext:bak | ext:old | ext:backup"
        "site:example.com inurl:login | inurl:signin | intitle:Login | intitle:"sign in" | inurl:auth"
        "site:example.com intext:"sql syntax near" | intext:"syntax error has occurred" | intext:"incorrect syntax near" | intext:"unexpected end of SQL command" | intext:"Warning: mysql_connect()" | intext:"Warning: mysql_query()" | intext:"Warning: pg_connect()""
        "site:example.com "PHP Parse error" | "PHP Warning" | "PHP Error""
        "site:example.com ext:php intitle:phpinfo "published by the PHP Group""
        "site:pastebin.com | site:paste2.org | site:pastehtml.com | site:slexy.org | site:snipplr.com | site:snipt.net | site:textsnip.com | site:bitpaste.app | site:justpaste.it | site:heypasteit.com | site:hastebin.com | site:dpaste.org | site:dpaste.com | site:codepad.org | site:jsitor.com | site:codepen.io | site:jsfiddle.net | site:dotnetfiddle.net | site:phpfiddle.org | site:ide.geeksforgeeks.org | site:repl.it | site:ideone.com | site:paste.debian.net | site:paste.org | site:paste.org.ru | site:codebeautify.org  | site:codeshare.io | site:trello.com "example.com""
        "site:github.com | site:gitlab.com "example.com""
        "site:stackoverflow.com "example.com""
        "site:example.com inurl:signup | inurl:register | intitle:Signup"
        "site:*.example.com"
        "site:*.*.example.com"
        "https://web.archive.org/web/*/example.com/*"
        "(example.com) (site:*.*.29.* |site:*.*.28.* |site:*.*.27.* |site:*.*.26.* |site:*.*.25.* |site:*.*.24.* |site:*.*.23.* |site:*.*.22.* |site:*.*.21.* |site:*.*.20.* |site:*.*.19.* |site:*.*.18.* |site:*.*.17.* |site:*.*.16.* |site:*.*.15.* |site:*.*.14.* |site:*.*.13.* |site:*.*.12.* |site:*.*.11.* |site:*.*.10.* |site:*.*.9.* |site:*.*.8.* |site:*.*.7.* |site:*.*.6.* |site:*.*.5.* |site:*.*.4.* |site:*.*.3.* |site:*.*.2.* |site:*.*.1.* |site:*.*.0.*)"

    )

    # replace and open query
    for QUERY in "${QUERIES[@]}"; do
        SEARCH_QUERY="${QUERY/example.com/$DOMAIN}"
        echo "Opening: $SEARCH_QUERY"
        xdg-open "https://www.google.com/search?q=${SEARCH_QUERY}" &>/dev/null
    done

    
}
 
# input file
if [ -f "$1" ]; then
    # Read the file and perform dorking on each domain
    while IFS= read -r DOMAIN; do
        perform_dorking "$DOMAIN"
    done < "$1"
else
    # Perform dorking on the single domain provided as an argument
    perform_dorking "$1"
fi