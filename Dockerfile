FROM node:alpine3.20

# 建议：将 WORKDIR 改为 /app。/tmp 在 Heroku 容器中可能会有权限或被清理的风险
WORKDIR /app

# 确保拷贝了所有文件
COPY . .

# 优化：合并安装命令，减少镜像层数
RUN apk update && apk upgrade &&\
    apk add --no-cache openssl curl gcompat iproute2 coreutils bash &&\
    # 显式给予所有文件权限，防止 index.js 无法执行
    chmod -R 777 /app &&\
    npm install

EXPOSE 3000/tcp

# 启动命令
CMD ["node", "index.js"]
