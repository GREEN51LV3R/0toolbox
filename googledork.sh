#!/bin/bash

# Check file or a domain
if [ -z "$1" ]; then
    echo "Usage: $0 <domain|file>"
    exit 1
fi

# Google Dorking on a single domain
perform_dorking() {
    local DOMAIN="$1"
    echo "Performing Google Dorking for domain: $DOMAIN"

    # Google Dork queries
    QUERIES=(
        "site:$DOMAIN intext:\"sql syntax near\" | intext:\"syntax error has occurred\" | intext:\"incorrect syntax near\" | intext:\"unexpected end of SQL command\" | intext:\"Warning: mysql_connect()\" | intext:\"Warning: mysql_query()\" | intext:\"Warning: pg_connect()\""
        "site:$DOMAIN \"PHP\""
        "site:$DOMAIN ext:php intitle:phpinfo"
        "site:pastebin.com | site:paste2.org | site:pastehtml.com | site:slexy.org | site:snipplr.com | site:snipt.net | site:textsnip.com | site:bitpaste.app | site:justpaste.it | site:heypasteit.com | site:hastebin.com | site:dpaste.org | site:dpaste.com | site:codepad.org | site:jsitor.com | site:codepen.io | site:jsfiddle.net | site:dotnetfiddle.net | site:phpfiddle.org | site:ide.geeksforgeeks.org | site:repl.it | site:ideone.com | site:paste.debian.net | site:paste.org | site:paste.org.ru | site:codebeautify.org | site:codeshare.io | site:trello.com \"$DOMAIN\""
        "site:github.com | site:gitlab.com \"$DOMAIN\""
        "site:stackoverflow.com \"$DOMAIN\""
        "site:$DOMAIN inurl:signup | inurl:register | intitle:Signup"
        "site:*.$DOMAIN"
        "site:*.*.$DOMAIN"
        "https://web.archive.org/web/*/$DOMAIN/*"
        "$DOMAIN (site:*.*.29.* | site:*.*.28.* | site:*.*.27.* | site:*.*.26.* | site:*.*.25.* | site:*.*.24.* | site:*.*.23.* | site:*.*.22.* | site:*.*.21.* | site:*.*.20.* | site:*.*.19.* | site:*.*.18.* | site:*.*.17.* | site:*.*.16.* | site:*.*.15.* | site:*.*.14.* | site:*.*.13.* | site:*.*.12.* | site:*.*.11.* | site:*.*.10.* | site:*.*.9.* | site:*.*.8.* | site:*.*.7.* | site:*.*.6.* | site:*.*.5.* | site:*.*.4.* | site:*.*.3.* | site:*.*.2.* | site:*.*.1.* | site:*.*.0.*)"
    )

    # Replace / open each query in a new tab
    for QUERY in "${QUERIES[@]}"; do
        echo "Opening: $QUERY"
        xdg-open "https://www.google.com/search?q=${QUERY}" &>/dev/null
    done
}

# argument is a file
if [ -f "$1" ]; then
    while IFS= read -r DOMAIN; do
        perform_dorking "$DOMAIN"
    done < "$1"
else
    #dorking on the single domain
    perform_dorking "$1"
fi
