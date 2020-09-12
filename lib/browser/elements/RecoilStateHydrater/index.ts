import {useRecoilCallback} from "recoil";
import {currentAccount} from "@clumsy_chinchilla/atoms";

export default function RecoilStateHydrater (properties) {
  const {children} = properties;
  const {mutableState} = properties;
  const currentAccountState = useRecoilCallback(({snapshot}) => async () => {
    console.log({currentAccount: await snapshot.getPromise<string>(currentAccount)});
  });

  currentAccountState();

  return children;
}
