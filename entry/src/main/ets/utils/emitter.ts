type ICallback = (...args: any[]) => void

class Emitter {
  private callbacks = {}

  on(eventName: string, cb: ICallback) {
    if (this.callbacks[eventName]) {
      this.callbacks[eventName].push(cb)
    } else {
      this.callbacks[eventName] = [cb]
    }
  }

  once(eventName: string, cb: ICallback) {
    const callback = (...args) => {
      cb(...args)
      this.off(eventName, callback);
    }
    this.on(eventName, callback);
  }

  emit(eventName: string, ...args: any[]) {
    if (!this.callbacks[eventName]) {
      // 事件不存在
      throw new Error(`${eventName}自定义事件不存在~`)
      return
    }

    this.callbacks[eventName].forEach(cb => cb(...args))
  }

  off(eventName?: string, cb?: ICallback) {
    if (!eventName) {
      // 解绑所有事件
      this.callbacks = {};
      return;
    }

    if (!this.callbacks[eventName]) {
      // 事件不存在
      throw new Error(`${eventName}自定义事件不存在~`)
      return
    }

    if (!cb) {
      // 解绑单个事件的所有回调函数
      delete this.callbacks[eventName]
      return;
    }

    // 解绑单个事件的单个回调
    this.callbacks[eventName] = this.callbacks[eventName].filter(callback => cb !== callback)
  }
}

export default Emitter;

export const globalEmitter = new Emitter();