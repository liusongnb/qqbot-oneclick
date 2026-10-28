# 小鲸鱼 QQ 机器人：现有功能分享版

这是独立安装包，版本 `1.12.0-share.1`。包含现有 AstrBot + NapCat 功能，不包含“识海”网页原型。

## 包含什么

- 授权群中的自然聊天、叫名字触发、连续接话、识图、现成表情、受限联网与少量主动开场。
- 仅授权群成员可私聊；同一个人的群聊和私聊共享长期偏好、昵称与习惯，近期对话分别保存。
- 免费 Edge TTS 晓伊或 BreezeBlue 官网 API；公共语音额度每天 2000 字，可填写自己的聊天语音豁免账号。
- 时笺 TimeAwareness 时间感知，以及智能日程提醒助手的适配后端。提醒统一从一个发送入口处理，按用户和原会话隔离，防止重复发送。
- 自然语言提醒和补充时间，例如“今天下午一点提醒我上课”“明天下午两点半”。提醒主要用文字；公共 TTS 余额至少 1500 字时才可能用语音，概率 20%，冷却 30 分钟。聊天豁免不豁免提醒语音计费。
- 当前小鲸鱼人设模板；不会附带原使用者的聊天、记忆、提醒、QQ 登录状态或密钥。

## 安装

支持 **Ubuntu 22.04/24.04、Debian 12/13 的 amd64 服务器**。建议 4 GB 内存，安装时至少有 1.5 GB 可用内存、8 GB 可用磁盘。ARM、Windows 服务器、其他发行版未在本版支持。

下载解压后执行：

```bash
sudo bash install.sh
```

安装向导要求：自己的 QQ 群号、OpenAI 兼容模型接口/模型名称/API Key；选用 BreezeBlue 时还需要自己的 Key 和音色 ID。免费语音默认选 Edge 晓伊。接口和语音的可用性、费用由各自服务提供方决定；识图需要模型支持图片。

安装路径固定为 `/opt/qqbot-share`，Compose 项目为 `qqbotshare`。如果发现已有 `/opt/qq-ai`、目标目录、同名项目或端口占用，就停止，不覆盖、不停掉已有服务。复用可用的 Docker；没有容器运行时的新服务器才会按 Docker 官方 apt 仓库安装。已有 Docker 不可用或缺少 Compose 时，会停止并说明原因。

镜像固定为 AstrBot 4.29.1 和 NapCat 4.18.37 的摘要版本。首次启动前创建空数据库、导入角色模板和私聊配置，避免新配置必须再手动保存一次的问题。群号只支持一个，权限检查默认拒绝未授权成员。

## 打开后台并扫码

后台只监听服务器回环地址，不直接对公网开放。**在自己电脑的终端**运行：

```bash
ssh -N -L 26185:127.0.0.1:16185 -L 26099:127.0.0.1:6099 用户名@服务器地址
```

保持终端开启，浏览器访问：

- AstrBot：<http://127.0.0.1:26185/>
- NapCat：<http://127.0.0.1:26099/webui/>

Windows 也可以在 PowerShell 执行下载包里的 `open-dashboards.ps1`，填写 SSH 地址，完成 SSH 登录后自动打开两个页面。远程无桌面的服务器终端本身不能打开你电脑的浏览器。

在服务器运行 `sudo qqbotctl credentials` 查看本实例后台凭据，首次登录 AstrBot 后按提示修改初始密码。在 NapCat 输入本实例 Token 后，用**新机器人的 QQ** 扫码确认登录，并把它加入安装时填写的群。登录状态只能由账号本人扫码确认。

不要把后台密码、Token 或 API Key 发进 QQ 或公开仓库。

## 常用指令

```bash
sudo qqbotctl status       # 容器和后台端口状态；不等同于 QQ 已在线
sudo qqbotctl start        # 启动本实例
sudo qqbotctl stop         # 仅停止本实例
sudo qqbotctl restart      # 仅重启本实例
sudo qqbotctl credentials  # 本机显示后台初始凭据
sudo qqbotctl backup       # 短暂停止本实例后做一致性备份，再恢复原来运行的容器
```

QQ 中可说“小鲸鱼你好”“记住我喜欢草莓”“我喜欢什么”“忘记我的记忆”“今天下午一点提醒我上课”“查看提醒”“取消提醒 R0001”。管理员也能在 AstrBot 插件配置页调整现有额度和开关。

备份保存在 `/opt/qqbot-share/backups/`，含密钥、登录状态和私人数据，权限为 600，只应由实例管理员私下保存。恢复时先停止本实例，把旧数据完整保留为另一个备份，再从确认过的备份还原；不要直接把其他人的数据库或登录目录混进来。

本版没有自动升级或自动覆盖。升级先备份、检查新版本说明再做显式迁移；重跑安装程序会拒绝覆盖现有目录。中途下载失败时配置会保留，可在该目录检查后继续 `sudo docker compose pull`、原生初始化及启动步骤；不要删除已有数据来试错。

## 验证与边界

随包文件清单为 `MANIFEST.sha256`，可运行 `sha256sum -c MANIFEST.sha256` 核对源码和素材。测试结论见发布页和 `VALIDATION.md`；离线测试不代表你提供的模型 Key、语音服务、QQ 扫码已可用。

安装器不改全局代理、防火墙、DNS，不挂载 Docker Socket，不使用 host 网络或特权容器。原生 AI 自动响应关闭，由现有伴聊插件统一处理，避免和提醒后端产生第二条发送路径。时间插件的 AI 日历和额外日程生成关闭。

## 来源与素材说明

- [AstrBot](https://github.com/AstrBotDevs/AstrBot/tree/v4.29.1)、[NapCat Docker](https://github.com/NapNeko/NapCat-Docker)。
- [TimeAwareness](https://github.com/W-Wolfycz/time_awareness) v2.3.3，固定提交 `0a2d187c42739b73fa4473c6e5a0d7e14c0acc88`。
- 智能日程提醒助手保留插件目录中的上游 README、原入口和适配说明；本版使用适配后端，不启动上游的第二个定时发送器。
- [Docker Ubuntu 官方安装说明](https://docs.docker.com/engine/install/ubuntu/)、[Debian 官方安装说明](https://docs.docker.com/engine/install/debian/)。

各组件保留其原许可证；本分享包不改变上游许可。表情素材保留 `STICKERS_NOTICE.md` 和 `WHALE_STICKERS_NOTICE.md`，仅用于个人非商业交流和技术演示，人物/图片权利属于原权利人，不提供商业素材授权。
