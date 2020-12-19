import React from "react";
import {useState} from "react";
import {useEffect} from "react";
import {useSetRecoilState} from "recoil";
import {useMutation} from "@apollo/client";
import {useQuery} from "@apollo/client";
import {useHistory} from "react-router-dom";

import {currentAccount as currentAccountAtom} from "@clumsy_chinchilla/atoms";
import {CheckboxField} from "@clumsy_chinchilla/elements";
import {Loading} from "@clumsy_chinchilla/elements";
import updateSettingsMutation from "./updateSettingsMutation.gql";
import fetchSettingsQuery from "./fetchSettingsQuery.gql";

interface UpdateSettingsMutation {
  updateSettings: {
    id: string;
  };
}

interface SettingsType {
  lightMode: boolean;
}

export default function SettingsForm (): JSX.Element {
  const history = useHistory();
  const setCurrentAccount = useSetRecoilState<string | null>(currentAccountAtom);
  const {loading: fetchSettingsLoading, data: fetchSettingsData, error: fetchSettingsError} = useQuery<SettingsType>(fetchSettingsQuery);
  const [updateSettings, {loading: updateSettingsLoading, error: updateSettingsError, data: updateSettingsData}] = useMutation<UpdateSettingsMutation>(updateSettingsMutation);
  const {lightMode: savedLightMode = true} = fetchSettingsData ?? {savedLightMode: true};
  const [lightMode, setLightMode] = useState(savedLightMode);

  useEffect(() => {
    if (updateSettingsData) {
      setCurrentAccount(updateSettingsData.updateSettings.id);
      history.push("/"); // TODO: This should be back instead
    }
  }, [updateSettingsData, setCurrentAccount, history]);

  if (fetchSettingsError) {
    throw fetchSettingsError;
  }

  if (updateSettingsError && updateSettingsError.message !== "incorrect_credentials") {
    throw updateSettingsError;
  }

  if (fetchSettingsLoading) {
    return <Loading kind="block" />;
  }

  const onSubmit = async (event: React.FormEvent<HTMLFormElement>): Promise<void> => {
    event.preventDefault();
    await updateSettings({variables: {input: {id, lightMode}}});
  };
  const onChangeLightMode = (): void => {
    setLightMode(!lightMode);
  };

  return <form id="SettingsForm" onSubmit={onSubmit}>
    <CheckboxField
      scope="SettingsForm"
      property="lightMode"
      label="Light Mode"
      hasValidated={false}
      inputAttributes={{
        readOnly: updateSettingsLoading,
        onChange: onChangeLightMode,
        autoComplete: "currentPassword",
        checked: lightMode,
      }}
    />
    <section>
      <button disabled={updateSettingsLoading} className="btn btn-primary" type="submit">
        Save Settings
      </button>
    </section>
  </form>;
}
