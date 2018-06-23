### 安装
    wget https://raw.github.com/wiyr/vim/master/install.sh -O - | bash

### 需要

- vim8
- git
- ack (option)
- cmake (ycm install required)
- ctag (自动生成ctag所需)



### 快捷键

| 快捷键       | 模式          | 功能                                 |
| ------------ | ------------- | ------------------------------------ |
| `;`          | normal/visual | 进入命令行                           |
| `,v`         | normal        | 编辑~/.vimrc                         |
| `,s`         | normal        | 重新读取~/.vimrc配置                 |
| `,pp`        | normal        | 进入paste模式                        |
| `,a`         | normal        | 搜索当前目录以及子目录               |
| `ctrl` + `j` | normal        | 向下切换窗口                         |
| `ctrl` + `k` | normal        | 向上切换窗口                         |
| `ctrl` + `h` | normal        | 向左切换窗口                         |
| `ctrl` + `l` | normal        | 向右切换窗口                         |
| `ctrl` + `h` | insert        | 左移                                 |
| `ctrl` + `l` | insert        | 右移                                 |
| `,y`         | visual        | 拷贝选中的行内容到~/.vbuf            |
| `,p`         | normal        | 粘贴~/.vbuf的内容                    |
| `,;`         | normal        | 在当前行末加分号                     |
| `*`          | visual        | 向下搜索选中的内容                   |
| `#`          | visual        | 向上搜索选中的内容                   |
| `,o`         | normal        | 打开最近使用文件列表查询             |
| `alt` + `f`  | normal        | 打开以当前项目为根路径的文件搜索列表 |
| `alt` + `b`  | normal        | 打开vim buffer的文件列表             |
| `gt`         | normal        | 使用ycm插件的函数定义追踪            |
| `ctrl` + `]` | normal        | 使用ctag的函数定义追踪               |
| `,t`         | normal        | 关闭/打开 ctag自动生成, for cpp file |
| `,tt`        | normal        | AsyncStop命令                        |
| `,n`         | normal        | 打开/关闭当前目录的文件列表          |
| `,T`         | normal        | 查找当前文件的地址                   |
| `,,j`        | normal        | 当前行快速下跳                       |
| `,,k`        | normal        | 当前行快速上跳                       |
| `,cs`        | visual        | 注释选中的代码                       |
| `,cu`        | visual        | 撤销选中代码的注释                   |
