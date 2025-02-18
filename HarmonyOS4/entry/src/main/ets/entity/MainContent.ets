import fileio from '@ohos.fileio';
// import {common} from '@kit.AbilityKit';
// import { relationalStore, ValuesBucket } from '@kit.ArkData';
import relationalStore from '@ohos.data.rdb';
import rdb from '@ohos.data.rdb';

export interface ContentDBInfo extends rdb.ValuesBucket {
  title: string
  image: string
  description: string
  filePath: string
  fileType: string
  device: string
}

// 隐私笔记数据库封装
class ContentDB {
  // 操作数据库的实例
  private store: relationalStore.RdbStore | null = null
  // 数据库表名
  private tableName = 'privacy_note'
  // 创建数据库的语句
  private sqlCreate = `CREATE TABLE IF NOT EXISTS ${this.tableName} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        content TEXT NOT NULL,
        date_added INTEGER NOT NULL
      )`

  // 获取数据库操作的实例
  async getStoreInstance() {
    // 如果数据库实例已存在，直接返回，没有才创建实例
    if (this.store) { return this.store }
    // 获取操作数据库的实例
    const store = await relationalStore.getRdbStore(getContext(), {
      name: 'guardian.db', // 数据库名称
      securityLevel: relationalStore.SecurityLevel.S1 // 安全等级
    })
    // 存储起来方便下次直接获取
    this.store = store
    // 返回 store 实例
    return this.store
  }

  // 查询数量
  async queryCount() {
    const store = await this.getStoreInstance()
    const predicates = new relationalStore.RdbPredicates(this.tableName)
    const resultSet = await store.query(predicates)
    return resultSet.rowCount > 0 ? resultSet.rowCount : 0
  }

  // 查询
  async query(id?: number) {
    const store = await this.getStoreInstance()
    const predicates = new relationalStore.RdbPredicates(this.tableName)
    // 倒序排列
    predicates.orderByDesc('id')
    // 如果有 id，添加 id 作为查询条件
    if (id) {
      predicates.equalTo('id', id)
    }
    const resultSet = await store.query(predicates)
    const list: ContentDBInfo[] = []
    while (resultSet.goToNextRow()) {
      // 获取行数据
      const row = resultSet.getRow() as ContentDBInfo
      // 追加到数组中
      list.push(row)
    }
    // 循环结束，释放结果集的内存空间（性能优化）
    resultSet.close()
    // 循环结束后，返回结果
    return list
  }

  // 删除
  async delete(ids: number[]) {
    const store = await this.getStoreInstance()
    const predicates = new relationalStore.RdbPredicates(this.tableName)
    predicates.in('id', ids)
    // 删除完成，返回受影响的行数
    return store.delete(predicates)
  }

  // 更新
  async update(item: Partial<ContentDBInfo>) {
    // 如果没有 id 直接退出
    if (!item.id) { return Promise.reject('id error') }
    const store = await this.getStoreInstance()
    const predicates = new relationalStore.RdbPredicates(this.tableName)
    predicates.equalTo('id', item.id)
    // 更新完成，返回受影响的行数
    return store.update(item, predicates)
  }


  // 类的构造器，new 的时候会自动触发
  constructor() {
    // 创建/打开数据库文件
    this.getStoreInstance()
      .then(store => {
        // 执行创建语句，用于创建数据库的表
        store.executeSql(this.sqlCreate)
      })
  }
}

// 通过小写 p 开头的类实例操作数据库，创建数据库，建表，增、删、查、改
export const contentDB = new ContentDB()

export class MainContent {
  title: string = ''
  image: string = 'app.media.background'
  description: string = ''
  filePath: string = ''; // 新增属性来存储文件路径
  fileType: string = ''; // 新增属性来存储文件格式
  device: string = ''; // 新增属性来存储设备

  constructor(title: string, image: string, description: string, filePath: string, fileType: string, device: string) {
    this.title = title;
    this.image = image;
    this.description = description;
    this.filePath = filePath;
    this.fileType = fileType;
    this.device = device;
  }

  // 新增方法来读取文件内容
  async readWriteFileWithStream(): Promise<void> {
    let context = getContext(this) as common.UIAbilityContext;
    let rootDir = context.filesDir;

    // 打开文件流
    let inputStream = fs.createStreamSync(rootDir + this.filePath, 'r+');

    try {
      // 以流的形式读取源文件内容并写入目的文件
      let bufSize = 4096;
      let readSize = 0;
      let buf = new ArrayBuffer(bufSize);
      let readOptions: ReadOptions = {
        offset: readSize,
        length: bufSize
      };
      let readLen = await inputStream.read(buf, readOptions);
      readSize += readLen;
      while (readLen > 0) {
        const writeBuf = readLen < bufSize ? buf.slice(0, readLen) : buf;

        // TODO: 创建一个输出流，用于传输文件

        readOptions.offset = readSize;
        readLen = await inputStream.read(buf, readOptions);
        readSize += readLen;
      }
    } catch (err) {
      console.error(`Failed to read file: ${err.message}`);
      throw new Error(`Failed to read file: ${err.message}`);
    } finally {
      // 关闭文件流
      inputStream.closeSync();
    }
  }

  // 新增方法来写入文件内容（分段写入）
  async appendFileContent(data: ArrayBuffer): Promise<void> {
    // 创建或打开文件流，使用 'a+' 模式表示追加模式
    let outputStream = fs.createStreamSync(this.filePath, 'a+');
    try {
      let writeOptions: WriteOptions = {
        offset: 0,
        length: data.byteLength
      };
      await outputStream.write(data, writeOptions);
      outputStream.closeSync();
    } catch (err) {
      console.error(`Failed to append file: ${err.message}`);
      throw new Error(`Failed to append file: ${err.message}`);
    }finally {
      // 关闭文件流
      outputStream.closeSync();
    }
  }
}
