import {atom} from "recoil";

export default atom<string | null>({
  "key": "currentSessionId",
  "default": null,
});
