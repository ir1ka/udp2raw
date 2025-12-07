FROM alpine AS build

WORKDIR /app

RUN apk add --no-cache --virtual .build-deps            \
            git cmake make gcc g++ linux-headers        \
    && git clone -b unified                             \
                 --depth 1                              \
                 --single-branch                        \
                 --shallow-submodules                   \
                 https://github.com/ir1ka/udp2raw.git   \
                 .                                      \
    && mkdir build                                      \
    && (cd build; cmake .. && make -j$(nproc))          \
    && ./build/udp2raw --help


FROM alpine

COPY --from=build /app/build/udp2raw /usr/bin/

ENTRYPOINT [ "udp2raw" ]
