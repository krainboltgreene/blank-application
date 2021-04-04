import {atom} from "recoil";

export default atom<Array<string>>({
  "key": "warningMessages",
  "default": [],
});
