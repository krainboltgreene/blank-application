import {create} from "@absinthe/socket";
import {createAbsintheSocketLink} from "@absinthe/socket-apollo-link";
import {Socket} from "phoenix";

// const {env} = process;
// const {REACT_APP_SOCKET_URL} = env;

export default createAbsintheSocketLink(
  create(
    new Socket(
      "ws://localhost:4000/socket",
      {},
    )
  )
);
