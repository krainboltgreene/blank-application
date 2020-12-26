import {atom} from "recoil";

export default atom<PouchDB.Database | null>({
  "key": "remoteDatabase",
  "default": null,
});
