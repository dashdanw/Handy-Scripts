cat requirements.txt | grep -v '^\-e' | cut -d= -f1 | xargs -I {} -n1 -P1 sh -c "echo \`curl -s https://pypi.org/project/{}/ | sed -e 's/^[[:space:]]*//' | grep '{} [0-9]' | sed -e 's/ /==/g'\`"
