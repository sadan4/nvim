#!/usr/bin/env node
const keys = "lkjhcq34erpo095\\fud";

/**
 * @param key {string}
*/
const makeKeymapping = (key) => {
    return {
        key: `ctrl+shift+alt+${key.toLowerCase()}`,
        command: "vscode-neovim.send",
        when: "editorTextFocus && neovim.mode !== insert",
        args: `<M-C-S-${key.toUpperCase()}>`
    }
}
console.log(JSON.stringify(keys.split("").map(makeKeymapping)))
