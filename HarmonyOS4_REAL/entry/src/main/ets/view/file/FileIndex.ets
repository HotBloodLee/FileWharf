import { MainContent } from '../../entity/MainContent';
import curves from '@ohos.curves';
import FileHeader from './FileHeader';
import TypePicker from './TypePicker';
import FileList from './FileList';

@Component
export default struct FileIndex {

  @Consume activeFileType: string; // 初始状态为 'all'
  @Consume activeDevice: string; // 初始状态为 'all'
  @Consume activeDeviceIdx: number;
  @Consume deviceList: Array<SelectOption>;
  @Consume mainContentArr: MainContent[];

  build() {
    Column() {
      Column() {
        FileHeader()
        Row() { // 创建一个行容器，用于水平布局
          TypePicker()
          FileList()
        }
        .width('100%') // 设置行容器的宽度为100%
        .height('100%') // 设置行容器的高度为100%
      }
      .height('100%')
      .width('100%')
    }
    .width('100%')
    .height('100%')
  }
}