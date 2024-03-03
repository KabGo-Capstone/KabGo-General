#!/bin/bash

PROTO_DIR=grpc/protos
SOURCE_DIR=grpc/models

npx grpc_tools_node_protoc \
    --ts_proto_out=$SOURCE_DIR \
    --ts_proto_opt=outputServices=grpc-js \
    --ts_proto_opt=esModuleInterop=true \
    -I=$PROTO_DIR $PROTO_DIR/*.proto

echo "generate protobuf successfully"