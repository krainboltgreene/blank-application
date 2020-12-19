import {atom} from "recoil";

export default atom<string | null>({
  "key": "currentAccount",
  "default": null,
});
