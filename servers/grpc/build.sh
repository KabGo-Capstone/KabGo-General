#!/bin/bash

PROTO_DIR=grpc/protos
SOURCE_DIR=grpc/proto_pb
PROTOC_GEN_TS_PATH=./node_modules/.bin/protoc-gen-ts_proto
PROTOC_GEN_TS_PATH="./node_modules/.bin/protoc-gen-ts_proto"
# PROTOC_GEN_GRPC_PATH="./node_modules/.bin/grpc_tools_node_protoc_plugin"

#Parse command line arguments or use default values
# while [[ $# -gt 0 ]]; do
#     case "$1" in
#         --proto-dir)
#             PROTO_DIR="$2"
#             shift 2
#             ;;
#         --source-dir)
#             SOURCE_DIR="$2"
#             shift 2
#             ;;
#         *)
#             echo "Invalid argument: $1"
#             exit 1
#             ;;
#     esac
# done

npx grpc_tools_node_protoc \
    --grpc_out="grpc_js:${SOURCE_DIR}" \
    --js_out=import_style=commonjs,binary:${SOURCE_DIR} \
    --ts_out="grpc_js:${SOURCE_DIR}"  \
    -I ./${PROTO_DIR} ${PROTO_DIR}/*.proto

# npx grpc_tools_node_protoc \
#     --grpc_out="grpc_js:${SOURCE_DIR}" \
#     --js_out="import_style=commonjs,binary:${SOURCE_DIR}" \
#     --ts_out="grpc_js:${SOURCE_DIR}"  \
#     --proto_path "${PROTO_DIR}" \
#     "${PROTO_DIR}/*.proto"

#Iterate over each file in the source directory
for file in "$SOURCE_DIR"/*; do
    if [[ -f "$file" ]]; then
        filename=$(basename -- "$file")
        extension="${filename##*.}"
        filename_no_ext="${filename%.*}"
        folder="${filename%%_*}"  

        mkdir -p $SOURCE_DIR/$folder

        if [[ $filename == *_grpc_pb.* ]]; then
            mv "$file" "$SOURCE_DIR/$folder/${filename_no_ext}.${extension}"
        elif [[ $filename == *_pb.* && $filename != *_grpc_pb.* ]]; then
            mv "$file" "$SOURCE_DIR/$folder/${filename_no_ext}.${extension}"
        fi
    fi
done