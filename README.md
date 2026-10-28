# 小鲸鱼 QQ 机器人：现有功能一键安装包

版本 `1.12.0-share.1`。包含群聊、仅授权群成员私聊、长期记忆共享、独立近期上下文、识图、表情、联网、BreezeBlue / Edge TTS、时间感知与自然语言提醒。**不含识海网页版，不含原账号和私人数据。**

在另一台 Ubuntu 22.04/24.04 或 Debian 12/13 **amd64** 服务器执行：

```bash
curl -fsSL https://raw.githubusercontent.com/liusongnb/qqbot-oneclick/main/get.sh | sudo bash
```

按向导填写自己的群号、模型接口和 Key，然后在 NapCat 后台本人扫码。推荐 4 GB 内存；安装时需 1.5 GB 可用内存、8 GB 可用磁盘。已有实例/目录/端口冲突会退出，不自动覆盖。请先查看安装脚本再以管理员身份运行。

- [下载 ZIP](https://raw.githubusercontent.com/liusongnb/qqbot-oneclick/main/qqbot-share-1.12.0-share.1.zip)
- [下载 Linux tar.gz](https://raw.githubusercontent.com/liusongnb/qqbot-oneclick/main/qqbot-share-1.12.0-share.1.tar.gz)
- [SHA256 校验文件](SHA256SUMS)
- [全部功能、后台与命令说明](GUIDE.md)
- [Linux 容器检查结果](../../actions)

安装后：`sudo qqbotctl status`、`sudo qqbotctl credentials`。后台通过 SSH 隧道访问，Windows 解压后可运行 `open-dashboards.ps1` 打开两个后台；QQ 登录必须由账号本人扫码。

现有功能离线回归 257 项、新安装检查 7 项通过；原生 Docker 启动以本仓库 Actions 对应提交结果为准。未使用真实模型/TTS 凭据或代发 QQ。

## 验证源码

运行包内有全部插件源代码、模板、素材出处和 `MANIFEST.sha256`；`verification.tar.gz` 是使用虚构数据的测试工具。工作流只在一次性 GitHub Ubuntu runner 启动测试实例，不接触原机器人服务器。

各组件遵守其原许可证。表情仅用于个人非商业交流和技术演示，保留包内素材说明，不提供商业素材授权。
