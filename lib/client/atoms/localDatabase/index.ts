import {atom} from "recoil";

export default atom<PouchDB.Database | null>({
  "key": "localDatabase",
  "default": null,
  "dangerouslyAllowMutability": true,
});
