# 写一个 fastapi server，监听get请求，请求参数为一个字符串，返回一个json， 以及一个post请求，请求参数为一个json，返回一个json

from fastapi import FastAPI, Request

app = FastAPI()

@app.get("/get")
def get(request: Request):
    # 打印请求体
    print(request)
    return {"query": "ok"}

@app.post("/post")
async def post(request: Request):
    # 打印请求体的内容
    body = await request.json()
    headers = request.headers
    print(body)
    print(headers)
    # 获取请求来自的ip
    print(request.client)
    return {"body": body}

# 运行
if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="127.0.0.1", port=10001)