import React from "react";
import {useState} from "react";
import {useEffect} from "react";
import {useRecoilState} from "recoil";
import {useMutation} from "@apollo/client";
import {useQuery} from "@apollo/client";
import {dig} from "@unction/complete";

import {profile as profileAtom} from "@clumsy_chinchilla/atoms";
import {CheckboxField} from "@clumsy_chinchilla/elements";
import {Loading} from "@clumsy_chinchilla/elements";
import updateProfileMutation from "./updateProfileMutation.gql";
import fetchProfileQuery from "./fetchProfileQuery.gql";
import type {UpdateProfileMutation} from "./UpdateProfileMutation.d";
import type {FetchProfileQuery} from "./FetchProfileQuery.d";

interface ProfileType {
  id: string;
  lightMode: boolean;
}

export default function ProfileForm (): JSX.Element {
  const [profile, setProfile] = useRecoilState<ProfileType | null>(profileAtom);
  const {loading: fetchProfileLoading, data: fetchProfileData, error: fetchProfileError} = useQuery<FetchProfileQuery>(fetchProfileQuery);
  const [updateProfile, {loading: updateProfileLoading, error: updateProfileError, data: updateProfileData}] = useMutation<UpdateProfileMutation>(updateProfileMutation);
  const {lightMode: savedLightMode = true} = dig<string, FetchProfileQuery | undefined, ProfileType | undefined>(["session", "account", "profile"])(fetchProfileData) ?? profile ?? {};
  const {id} = dig<string, FetchProfileQuery | undefined, ProfileType | undefined>(["session", "account", "profile"])(fetchProfileData) ?? profile ?? {};
  const [lightMode, setLightMode] = useState(savedLightMode);

  useEffect(() => {
    if (updateProfileData) {
      setProfile(updateProfileData.updateProfile);
    }
  }, [updateProfileData, setProfile, fetchProfileData]);
  useEffect(() => {
    if (fetchProfileData) {
      setProfile(fetchProfileData.session?.account.profile ?? null);
    }
  }, [fetchProfileData, setProfile]);

  if (fetchProfileError) {
    throw fetchProfileError;
  }

  if (updateProfileError?.message !== "incorrect_credentials") {
    // TODO: Actually handle real errors
    throw updateProfileError;
  }

  if (fetchProfileLoading) {
    return <Loading kind="block" />;
  }

  const onSubmit = async (event: React.FormEvent<HTMLFormElement>): Promise<void> => {
    event.preventDefault();
    await updateProfile({variables: {input: {id, lightMode}}});
  };
  const onChangeLightMode = (): void => {
    setLightMode(!lightMode);
  };

  return <form id="ProfileForm" onSubmit={onSubmit}>
    <CheckboxField
      scope="ProfileForm"
      property="lightMode"
      label="Light Mode"
      hasValidated={false}
      inputAttributes={{
        readOnly: updateProfileLoading,
        onChange: onChangeLightMode,
        autoComplete: "currentPassword",
        checked: lightMode,
      }}
    />
    <section>
      <button disabled={updateProfileLoading} type="submit">
        Save Profile
      </button>
    </section>
  </form>;
}
