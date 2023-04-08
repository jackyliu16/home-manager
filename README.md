## Willing of things 

- sample : a shell tools using for graph


## Neovim

### Mapping

#### LeaderF

-   using `<leader>f` to open menu

-   ```
    <C-C>, <ESC> : 退出
    <C-R> : 在模糊查询和正则表达式模式间切换
    <C-F> : 在全路径搜索和名字搜索模式间切换
    <Tab> : 切换成normal模式
    <C-V>, <S-Insert> : 从剪切板里copy字符串进行查询
    <C-U> : 清除已经打出的字符
    <C-J>, <C-K> : 在结果列表中移动
    <Up>, <Down> : 从历史记录里调出上一次/下一次的输入pattern
    <2-LeftMouse> or <CR> : 打开在光标处的文件或者被选择的多个文件
    <F5>  : 刷新缓存
    <C-P> : 预览选中结果
    <C-Up> : 在预览popup窗口里滚动向上
    <C-Down> : 在预览popup窗口里滚动向下
    ```

-   reference

    -   https://retzzz.github.io/dc9af5aa/

#### [Surround](http://yyq123.github.io/learn-vim/learn-vim-plugin-surround.html)

#### Useful

##### Code Fold

- using `zf` to fold select code
- using `zfa()` to fold `()`
- using `za` open/close current folding
  - using `zc` close      ~
  - using `zo` open       ~
  - using `zm` to close all folding
  - using `zM` to nesting close all folding
  - using `zr` to open all folding
  - using `zR` to nesting open all folding
- delete
  - using `zd` to delete current folding
  - using `zE` to delete all folding
- move between folding
  - using `zj` move to next folding
  - using `zk` move to prev folding
- using `zn`/`zN` disable/enable folding

#### Markdown Operation

- using `<C-p>` to open a markdown file in browser

#### Vim Windows

[help page](http://yyq123.github.io/learn-vim/learn-vi-14-MultiWindows.html)

#### Commentary

- using `gc`  comment out a line
- using `gcc` comment out target of a motion
  - using `gcap` comment out a paragraph

#### Terminal

- using Alt + 1~3 to using 3 different ways to start a new terminal
- using Ctrl + W to kill current terminal (bufferline)
- using Ctrl + j to open and close terminal 

#### [Terminal Windows Controls](https://www.cnblogs.com/xiaodi-js/p/9181062.html)

##### Split

| horizontal split | vertical split | Close the active window | Close other windows |
| ---------------- | -------------- | ----------------------- | ------------------- |
| `<Ctrl-W> + S`   | `<Ctrl-W> + V` | `<Ctrl-W> + C`          | `<Ctrl-W> + O`      |
|                  |                |                         |                     |



#### Nvim-Tree

`:cd %:h`set the working directory to buffer parent folder

![image about it's ShortCut](https://user-images.githubusercontent.com/17254073/195207023-7b709e35-7f10-416b-aafb-5bb61268c7d3.png)

#### Nomenclatur 

| Normal            | Abbreviation            |
| ----------------- | ----------------------- |
| Ctrl + sth        | \<C-?\>                   |
| space, esc, shift | \<Space\>, \<ESC\>, \<shift\> |
| Alt + sth         | \<A\>                     |
| back space        | \<BS\>                    |
| carriage return   | \<CR\>                    |
| f1 - f12          | \<f1\> - \<f12\>            |

## terminal 

### Zsh Plugins 

#### sudo

- allow to using double click <ESC> to auto add sudo to the top of the command, which failure because wasn't run in sudo mode. 

[home-page](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/sudo)

#### web_search

- allow to using `<search engine> <information>` to search in the terminal.
- allow to using `wiki`, `news`, `youtube`, `map`, `image`, `ducky` .

[home-page](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/web-search)

#### Dirhistory

| ShortCut    | Description    |
| ----------- | -------------- |
| Alt + Left  | prev directory |
| Alt + Right | next directory |
| Alt + Up    | Parent         |
| Alt + Dow   | First Child    |

[home-page](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/dirhistory)

#### History

- allow to search the command which contains the input args.
- hsi <info>

[home-page](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/history)

#### pp_json

> if you using pipe to put the info into pp_json, it will make it visual.

[home-page](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/jsontools)


