import {atom} from "recoil";

interface ProfileType {
  id: string;
  publicName?: string | null;
}

export default atom<ProfileType | null>({
  "key": "profile",
  "default": null,
});
