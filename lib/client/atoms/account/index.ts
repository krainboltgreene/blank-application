import {atom} from "recoil";

interface AccountType {
  id?: string;
  username?: string | null;
  emailAddress?: string | null;
}

export default atom<AccountType | null>({
  "key": "account",
  "default": null,
});
