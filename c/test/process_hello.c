#include <cstdext/core.h>
#include <stdio.h>
#include <stdint.h>

enum ipc_kind {
  IPC_KIND_ASK = 1,
  IPC_KIND_REPLY,
  IPC_KIND_EVENT,
};

enum ipc_type {
  IPC_HANDSHAKE_HELLO = 1,
  IPC_HANDSHAKE_WELCOME
};

enum  {
  IPC_PAYLOAD_MAX = 64u * 1024u,
};

typedef struct icp_msg_s {
  u32 id;
  u32 reply_to_id;
  u8 ipc_kind;

  i8 payload[];
} ipc_msg_t;


