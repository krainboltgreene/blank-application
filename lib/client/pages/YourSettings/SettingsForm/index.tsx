import {useState} from "react";
import {useEffect} from "react";
import {useRecoilState} from "recoil";
import {useMutation} from "@apollo/client";
import {useQuery} from "@apollo/client";

import {settings as settingsAtom} from "@find_reel_love/atoms";
import {CheckboxField} from "@find_reel_love/elements";
import {Loading} from "@find_reel_love/elements";
import updateSettingsMutation from "./updateSettingsMutation.gql";
import fetchYourSettingsQuery from "./fetchYourSettingsQuery.gql";
import type {UpdateSettingsMutation} from "./UpdateSettingsMutation";
import type {FetchYourSettingsQuery} from "./FetchYourSettingsQuery";

export default function SettingsForm (): JSX.Element {
  const [clientSettings, setSettings] = useRecoilState(settingsAtom);
  const {loading: fetchSettingsLoading, data: fetchSettingsData, error: fetchSettingsError} = useQuery<FetchYourSettingsQuery>(fetchYourSettingsQuery);
  const [updateSettings, {loading: updateSettingsLoading, error: updateSettingsError, data: updateSettingsData}] = useMutation<UpdateSettingsMutation>(updateSettingsMutation);
  const {lightMode: clientLightMode} = clientSettings ?? {};
  const serverSettings = fetchSettingsData?.session?.account.settings ?? {id: null};
  const {id} = serverSettings;
  // const {lightMode: serverLightMode} = serverSettings;
  const [lightMode, setLightMode] = useState(clientLightMode);

  useEffect(() => {
    if (fetchSettingsData) {
      setSettings(fetchSettingsData.session?.account.settings ?? null);
    }
  }, [fetchSettingsData, setSettings]);
  useEffect(() => {
    if (updateSettingsData) {
      setSettings(updateSettingsData.updateSettings);
    }
  }, [updateSettingsData, setSettings, fetchSettingsData]);

  if (fetchSettingsError) {
    throw fetchSettingsError;
  }

  if (updateSettingsError && updateSettingsError.message !== "incorrect_credentials") {
    // TODO: Actually handle real errors
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
    if (typeof lightMode !== "undefined") {
      setLightMode(!lightMode);
    }
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
        checked: lightMode,
      }}
    />
    <section>
      <button disabled={updateSettingsLoading} type="submit">
        Save Settings
      </button>
    </section>
  </form>;
}
