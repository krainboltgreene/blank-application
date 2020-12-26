import React from "react";
import {useState} from "react";
import {useEffect} from "react";
import {useRecoilState} from "recoil";
import {useMutation} from "@apollo/client";
import {useQuery} from "@apollo/client";
import {dig} from "@unction/complete";

import {settings as settingsAtom} from "@clumsy_chinchilla/atoms";
import {CheckboxField} from "@clumsy_chinchilla/elements";
import {Loading} from "@clumsy_chinchilla/elements";
import updateSettingsMutation from "./updateSettingsMutation.gql";
import fetchSettingsQuery from "./fetchSettingsQuery.gql";

interface UpdateSettingsMutation {
  updateSettings: {
    id: string;
    lightMode: boolean;
  };
}
interface FetchSettingsQuery {
  session: {
    id: string;
    account: {
      id: string;
      settings: {
        id: string;
        lightMode: boolean;
      };
    };
  };
}

interface SettingsType {
  id: string;
  lightMode: boolean;
}

export default function SettingsForm (): JSX.Element {
  const [settings, setSettings] = useRecoilState<SettingsType | null>(settingsAtom);
  const {loading: fetchSettingsLoading, data: fetchSettingsData, error: fetchSettingsError} = useQuery<FetchSettingsQuery>(fetchSettingsQuery);
  const [updateSettings, {loading: updateSettingsLoading, error: updateSettingsError, data: updateSettingsData}] = useMutation<UpdateSettingsMutation>(updateSettingsMutation);
  const {lightMode: savedLightMode = true} = dig<string, FetchSettingsQuery | undefined, SettingsType | undefined>(["session", "account", "settings"])(fetchSettingsData) ?? settings ?? {};
  const {id} = dig<string, FetchSettingsQuery | undefined, SettingsType | undefined>(["session", "account", "settings"])(fetchSettingsData) ?? settings ?? {};
  const [lightMode, setLightMode] = useState(savedLightMode);

  useEffect(() => {
    if (updateSettingsData) {
      setSettings(updateSettingsData.updateSettings);
    }
  }, [updateSettingsData, setSettings, fetchSettingsData]);
  useEffect(() => {
    if (fetchSettingsData) {
      setSettings(fetchSettingsData.session.account.settings);
    }
  }, [fetchSettingsData, setSettings]);

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
    console.log({settings});
    console.log({fetchSettingsData});
    console.log({id});
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
