import {atom} from "recoil";

interface SettingsType {
  id: string;
  lightMode: boolean;
}
export default atom<SettingsType | null>({
  "key": "settings",
  "default": null,
});
