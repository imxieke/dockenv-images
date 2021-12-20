#!/usr/bin/env bash
###
 # @Author: Cloudflying
 # @Date: 2021-12-20 08:53:57
 # @LastEditTime: 2021-12-20 21:38:41
 # @LastEditors: Cloudflying
 # @Description: Code Server Start Params Script
 # @FilePath: /dockenv/images/boxs/vscode/entrypoint.sh
###

mkdir -p ~/.vscode/User
cat > ~/.vscode/User/settings.json << EOF
{
    "workbench.colorTheme": "Monokai",
    "editor.fontSize": 16,
    "sublimeTextKeymap.promptV3Features": true,
    "editor.multiCursorModifier": "ctrlCmd",
    "editor.snippetSuggestions": "top",
    "editor.formatOnPaste": true,
    "workbench.iconTheme": "vscode-icons"
}

EOF

# Custom
echo 'alias code-install-ext="code-server --user-data-dir ~/.vscode --install-extension"' >> ~/.zshrc

if [[ -z "${CODE_PASSWD}" ]]; then
    CODE_PASSWD=$(cat /dev/random | head -n 1 | sha256sum | head -c 12)
fi

export PASSWORD=${CODE_PASSWD}

if [[ -z "${CODE_PORT}" ]]; then
    CODE_PORT=8080
fi

echo "======================================================================" > /tmp/.boxs.run.log
echo "              Code Server PASSWORD: ${PASSWORD}                       " >> /tmp/.boxs.run.log
echo "======================================================================" >> /tmp/.boxs.run.log
echo "                  Boxs ssh is Running                                 " >> /tmp/.boxs.run.log
echo "======================================================================" >> /tmp/.boxs.run.log

code-server --user-data-dir ~/.vscode --bind-addr 0.0.0.0:${CODE_PORT} $@
