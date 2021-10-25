import React from "react";
import type {FormEvent} from "react";
import {useState} from "react";
import {useEffect} from "react";
import {useRecoilState} from "recoil";
import {useMutation} from "@apollo/client";
import {useQuery} from "@apollo/client";

import {settings as settingsAtom} from "@client/atoms";
import {CheckboxField} from "@client/elements";
import {Loading} from "@client/elements";
import updateSettingsMutation from "./updateSettingsMutation.graphql";
import fetchMySettingsQuery from "./fetchMySettingsQuery.graphql";
import type {FetchMySettingsQuery} from "@client/types";
import type {UpdateSettingsMutation} from "@client/types";

export default function SettingsForm (): JSX.Element {
  const [clientSettings, setSettings] = useRecoilState(settingsAtom);
  const {loading: fetchSettingsLoading, data: fetchSettingsData, error: fetchSettingsError} = useQuery<FetchMySettingsQuery>(fetchMySettingsQuery);
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
    if (typeof updateSettingsData === "undefined" || updateSettingsData === null) {
      return;
    }
    if (typeof updateSettingsData.updateSettings === "undefined" || updateSettingsData.updateSettings === null) {
      return;
    }
    setSettings(updateSettingsData.updateSettings);
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

  const onSubmit = async (event: FormEvent<HTMLFormElement>): Promise<void> => {
    event.preventDefault();
    await updateSettings({variables: {input: {id, lightMode}}});
  };
  const onChangeLightMode = (): void => {
    if (typeof lightMode !== "undefined") {
      setLightMode(!lightMode);
    }
  };

  return <form id="SettingsForm" className="row g-3" onSubmit={onSubmit}>
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
      <button disabled={updateSettingsLoading} type="submit" className="btn btn-primary">
        Save
      </button>
    </section>
  </form>;
}