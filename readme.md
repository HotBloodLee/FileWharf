# 计划

构建一个跨平台的数据工作台（方便实时数据共享传递）
Windows端：待定
iOS：Swift
鸿蒙：Ark
Mac：Swift

设计：
通过主从方式，构建多端分布式数据共享协议。由于是单人使用，所以在数据一致性上压力小，基本是串行场景。
需要针对不同平台的特性，制定不同的端内数据上传下载机制
端间通过特定的协议同步数据，拉取数据，维护各自的数据可见性

**软件方案设计：基于P2P机制的“数据坞”**

**1. 总体目标**
设计一款支持多平台（Windows、iOS、鸿蒙、macOS）的文件共享工具，通过借助移动端 **分享机制** 和 **鸿蒙中转站** 功能，方便用户在多个设备间无缝共享文本、图片及小文件。用户无需复杂操作，只需使用设备自带的分享功能或中转站，即可将文件快速同步至其他设备。

设计一款基于P2P架构的多端文件共享工具，无需依赖中心服务器，支持在局域网中设备间自动发现与互通。文件共享过程分为“文件信息广播”和“文件请求传输”两个阶段，确保高效共享与文件信息管理。

**2. 功能需求**

**核心功能**

1. **设备自动发现：**
• 在同一局域网内，设备通过广播发现其他“数据坞”应用实例。
• 支持动态设备加入与退出，不需用户手动配置。
• 每个设备拥有唯一的设备标识（ID）。

1. **多端文件共享：**

• **文件上传：**
• 在电脑端通过拖放文件至“数据坞”软件。
• 移动端通过分享菜单（iOS/鸿蒙）直接将文件上传至“数据坞”。
• 鸿蒙设备可直接通过“中转站”与“数据坞”对接，快速共享文件。

• **文件接收：**
• “数据坞”接收到共享数据后，其他在线设备实时同步，支持跨平台文件查看与下载。

• 用户将文件拖放至“数据坞”应用，应用会广播该文件的元数据信息（如文件名、大小、摘要等）。

• 文件元数据包括：
	• 文件唯一标识（Hash，SHA256等）。
	• 文件名、类型、大小。
	• 当前设备的存储状态（是否可提供该文件）。

• 设备退出时，所共享的文件信息会从其他设备的信息列表中自动清除，除非其他设备也保存了该文件。

2. **文件预览与下载：**

• **预览支持：**
• 图片（JPEG/PNG/GIF）、文本文件（TXT/Markdown）、文档（PDF/Office文件）。

• **下载保存：**
• 一键保存文件至设备本地。
• 用户可选择文件存储路径。

4. **文件状态管理：**
• 如果某设备退出，文件信息列表会自动更新，确保只有至少一个设备存储完整文件时，文件信息仍保留。
• 文件传播管理：
	• 如果文件在多个设备上存在，优先从较近或较快的设备传输。
	• 文件信息自动清理无存储设备的记录，防止数据冗余。

5. **传输优化：**
• 局域网内传输速度优化，支持多点下载。
• 文件传输断点续传支持。

6. **历史记录：**
• 按时间或设备来源，记录已下载的文件。
• 提供重新下载或删除选项。

**3. 技术方案**

**P2P架构设计**

1. **设备发现：**
• 使用 **mDNS（Multicast DNS）** 或 **UDP广播** 实现局域网内自动发现。
• 每个设备通过定期广播自己的状态（设备ID、共享文件元数据），实现动态网络拓扑。

2. **文件信息广播：**
• 广播协议基于轻量化 **UDP**，只传输文件元数据（如文件名、大小、Hash等）。
• 数据量小，确保高效性和实时性。
• 元数据更新后，其他设备自动同步。

3. **文件传输：**
• 基于 **TCP** 或 **WebRTC** 点对点连接进行文件块传输。
• 传输过程分块（例如4MB一块），支持并发下载和断点续传。
• 引入 **Hash校验** 确保数据完整性。

4. **文件信息维护：**
• 每个设备保存一个“文件索引表”，记录其他设备的共享文件状态。
• 当设备退出时，其提供的文件元数据会从索引表中清除，除非其他设备也拥有相同文件。

**数据模型**

• **设备表：**
• 记录局域网内所有在线设备及其状态。
• 关键字段：设备ID、IP地址、状态。

• **文件索引表：**
• 存储所有共享文件的元数据。
• 关键字段：文件Hash、文件名、大小、提供设备列表。

• **文件块传输表：**
• 记录文件块传输状态（完成/未完成）。

**4. 用户体验设计**

**界面结构**
  
1. **主界面：**
• 文件拖放区域：用户上传文件。
• 文件列表区域：显示局域网中可用的共享文件信息。
• 设备状态：显示已发现的设备及其文件共享状态。

2. **文件详情界面：**
• 显示文件元数据（如文件名、大小、来源设备等）。
• 提供下载按钮，支持实时查看下载进度。

3. **通知与状态：**
• 当设备加入/退出时，弹出通知提示。
• 文件传输完成或失败时，提供反馈信息。

**用户操作流程**

1. **文件上传：**
• 用户将文件拖拽至软件窗口，文件元数据即刻广播到局域网。

2. **文件同步：**
• 其他设备接收到元数据后更新文件列表。

3. **文件下载：**
• 用户在文件列表中选择需要的文件 -> 自动从最近设备传输。

4. **设备退出：**
• 当设备退出，其他设备检查是否有剩余设备存储该文件。
• 如果文件完全失效，则从索引中清理。

**1. 文件索引和设备信息的存储方案**

**1.1 存储结构**
每个设备独立维护以下数据结构：

1. **设备表（内存中的哈希表）：**
• 存储已发现的设备信息，包括设备ID、IP地址、当前在线状态等。
• 每次设备状态变更时，通过局域网广播同步。

2. **文件索引表（内存中的哈希表）：**
• 保存文件的元数据信息，包括文件的唯一标识、元数据和持有设备列表。
• 结构示例如下：
```
{
  "file_hash_1": {
    "name": "example.jpg",
    "size": "1.2MB",
    "devices": ["device_1", "device_2"]
  },
  "file_hash_2": {
    "name": "document.pdf",
    "size": "500KB",
    "devices": ["device_3"]
  }
}
```
• 文件的唯一标识可基于文件内容生成的 **Hash值**（如SHA-256），确保去重和唯一性。

3. **本地持有文件的列表（持久化存储）：**
• 记录当前设备持有的文件清单。
• 使用轻量化文件存储，如 **SQLite** 或本地文件系统（JSON或二进制存储文件）。

**2. 索引的管理与同步**

**2.1 文件信息广播与同步**
  
1. **广播机制：**
• 设备在局域网内通过 **UDP广播** 或 **mDNS** 定期（如每5秒）发送以下内容：
• 当前在线的文件列表（仅文件元数据，不包括实际文件内容）。
• 当前设备的状态（是否在线）。
• 示例广播数据包：
```
{
  "device_id": "device_1",
  "files": [
    {"hash": "file_hash_1", "name": "example.jpg", "size": "1.2MB"},
    {"hash": "file_hash_2", "name": "document.pdf", "size": "500KB"}
  ]
}
```

2. **接收广播与索引更新：**
• 每个设备监听局域网广播（UDP端口），收到广播后：
• 更新设备表，记录在线设备。
• 更新文件索引表，合并新的文件元数据。
• 当某个文件的所有设备下线时，自动清除该文件的索引。

**2.2 离线设备文件清理**
• 每个文件索引都维护“可用设备列表”：
• 当某设备下线，其他设备会通过对比文件索引表，移除对应的设备记录。
• 如果某文件不再有任何持有设备，则从索引表中删除。

**2.3 冲突检测与解决**
• 文件索引以文件Hash为唯一标识，不存在命名冲突问题。
• 如果不同设备广播了同一个文件Hash，但元数据有差异（如文件名不同），以优先到达的广播为准。

**3. 数据存储与持久化**

**3.1 索引表的本地持久化**
• 文件索引表和设备表的内容可按需持久化到磁盘，防止程序重启导致数据丢失。
• 持久化方案：
• 使用本地 **JSON文件** 存储索引表，定期保存或在广播接收后保存。
• 示例文件：
```
{
  "file_hash_1": {
    "name": "example.jpg",
    "size": "1.2MB",
    "devices": ["device_1", "device_2"]
  }
}
```

**3.2 本地文件清单**
• 当前设备实际持有的文件列表需要单独持久化：
• 可以使用轻量数据库（如SQLite）。
• 数据示例：
```
{
  "file_hash_1": {
    "path": "/data/example.jpg",
    "last_accessed": "2024-11-20T12:00:00"
  }
}
```

**3.3 自动清理与维护**
• 定期检查文件索引和本地清单：
• 如果本地存储的文件已被删除，通知其他设备更新索引。
• 定期移除长时间未访问的文件元数据。

**4. 文件传输与完整性保障**

**4.1 请求文件传输**
• 用户点击某个文件下载时，客户端通过文件索引表找到可用的设备列表，并发起文件传输请求。
• 请求流程：
	• 选择最快的设备（可基于Ping值或网络性能评估）。
	• 向目标设备发送请求（使用TCP/WebRTC连接）。
	• 文件分块传输，支持断点续传。

**4.2 文件块校验与恢复**
• 每个文件传输时分为固定大小的块（如4MB）。
• 每个块有独立的Hash值，接收端校验每个块的完整性。
• 如果某块丢失或传输失败，可以向其他设备请求该块。

**4.3 文件多源下载**
• 当文件的多个块分别存储在不同设备上时：
• 客户端可以并发向多个设备请求传输不同的块。
• 块传输完成后在本地重组文件。

**1. 提供文件的设备掉线**

**问题**
• 提供文件的设备掉线，导致文件传输中断，接收方无法获得完整文件。

**解决方案**

1. **支持断点续传：**
• 传输文件时分块进行，每块传输完成后，接收方记录已经完成的块信息。
• 使用文件块的 **索引表** 保存状态：
```
{
  "file_hash": "file_hash_1",
  "total_blocks": 100,
  "received_blocks": [1, 2, 3, 10, 11, 12],
  "pending_blocks": [4, 5, 6, 7, 8, 9, 13, 14, ...]
}
```

2. **动态切换数据源：**
• 文件的元数据广播中包含所有存储该文件的设备列表。
• 当一个设备掉线时，接收方自动切换到其他拥有该文件的设备继续请求未完成的块。
• 策略：
	• 优先选择网络条件最佳的设备（如Ping值最低）。
	• 如果只有一个设备拥有文件，则等待该设备重新上线或清理传输记录。

3. **重试机制：**
• 如果暂时没有其他设备持有该文件，接收方记录未完成的块状态，定期（如10秒）重新尝试从新的设备获取。

4. **通知机制：**
• 如果接收方在设定的超时时间内（如30秒）未能完成文件传输，通知用户传输失败并提供恢复选项。
• 恢复时检查网络状态和其他设备可用性。

**2. 接收文件的设备掉线**

**问题**
• 接收文件的设备掉线，导致文件传输被中断，提供方可能继续浪费带宽尝试发送。

**解决方案**

1. **实时心跳检测：**
• 提供方在传输文件时，周期性（如每秒）通过心跳包确认接收方的在线状态。
• 如果在连续几次（如3次）心跳检测中未收到响应，提供方暂停传输并标记为中断。

2. **中断清理：**
• 如果传输中断，提供方停止发送后，记录已完成的块信息：
```
{
  "file_hash": "file_hash_1",
  "blocks_sent": [1, 2, 3, 4, 5]
}
```

3. **恢复机制：**
• 当接收方重新上线时，可以重新请求文件，附带已经接收的块信息，避免重复传输：
```
{
  "file_hash": "file_hash_1",
  "missing_blocks": [6, 7, 8, 9, 10]
}
```

4. **通知机制：**
• 提供方记录传输中断状态并通知用户。
• 如果接收方重新上线且发送恢复请求，提供方恢复文件传输。

**3. 文件传输的设计改进**
为了增强文件传输的可靠性，以下设计改进可以提高系统的鲁棒性：

**3.1 分块传输设计**
• 文件被拆分为固定大小的块（如4MB）。
• 每个块有唯一编号（Block ID）和独立的Hash值，确保传输可靠性和数据完整性。

**3.2 文件块分布式存储**
• 当一个文件在多个设备上存储时，不必每个设备都保存完整文件，可以采用 **分块冗余机制**：
	• 不同设备保存文件的不同块。
	• 当设备掉线时，其他设备的块可以补充传输。
	• 引入冗余存储（如RS编码）以提升可靠性。

**3.3 中断状态持久化**
• 接收方和提供方在文件传输中断后，均可持久化当前传输状态：
	• 提供方记录已发送的块。
	• 接收方记录已接收的块。
	• 状态恢复后，可以基于持久化数据继续传输。

**3.4 动态传输优化**
• 当设备掉线后，接收方可以动态发现其他存储完整文件的设备。
• 优先选择带宽更快、传输稳定的设备。

**4. 用户交互与体验**

• **中断通知：**
• 如果掉线发生，系统通过弹窗或消息通知用户，并提示可恢复的状态。

• **传输恢复界面：**
• 用户重新启动“数据坞”时，未完成的传输任务会自动显示在任务列表中，用户可以选择继续或放弃。

• **实时进度展示：**
• 显示当前已完成块的数量及剩余任务。
• 提供详细的错误信息（如设备掉线、网络中断等）。

**5. 总结**
设备掉线在P2P场景下是不可避免的，但通过以下机制可以显著缓解其影响：
1. **分块传输与断点续传** 确保文件传输的灵活性。
2. **动态数据源切换** 提升传输的成功率。
3. **心跳检测与中断清理** 避免资源浪费。
4. **状态持久化与恢复机制** 保障文件传输不中断。
如果需要更高的容错率，可以进一步优化传输协议或引入分布式冗余存储方案。