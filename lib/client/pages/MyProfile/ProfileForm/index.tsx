import React from "react";
import type {FormEvent} from "react";
import type {ChangeEvent} from "react";
import {useState} from "react";
import {useEffect} from "react";
import {useRecoilState} from "recoil";
import {useMutation} from "@apollo/client";
import {useQuery} from "@apollo/client";

import {profile as profileAtom} from "@clumsy_chinchilla/atoms";
import {Field} from "@clumsy_chinchilla/elements";
import {Loading} from "@clumsy_chinchilla/elements";
import updateProfileMutation from "./updateProfileMutation.graphql";
import fetchYourProfileQuery from "./fetchYourProfileQuery.graphql";
import type {FetchYourProfileQuery} from "@clumsy_chinchilla/types";
import type {UpdateProfileMutation} from "@clumsy_chinchilla/types";

export default function ProfileForm (): JSX.Element {
  const [profile, setProfile] = useRecoilState(profileAtom);
  const {loading: fetchProfileLoading, data: fetchProfileData, error: fetchProfileError} = useQuery<FetchYourProfileQuery>(fetchYourProfileQuery);
  const [updateProfile, {loading: updateProfileLoading, error: updateProfileError, data: updateProfileData}] = useMutation<UpdateProfileMutation>(updateProfileMutation);
  const {publicName: savedPublicName} = profile ?? {};
  const {id} = fetchProfileData?.session?.account.profile ?? {};
  const [publicName, setPublicName] = useState(savedPublicName ?? "");

  useEffect(() => {
    if (typeof updateProfileData === "undefined" || updateProfileData === null) {
      return;
    }
    if (typeof updateProfileData.updateProfile === "undefined" || updateProfileData.updateProfile === null) {
      return;
    }
    setProfile(updateProfileData.updateProfile);
  }, [updateProfileData, setProfile, fetchProfileData]);
  useEffect(() => {
    if (typeof fetchProfileData === "undefined") {
      return;
    }
    setProfile(fetchProfileData.session?.account.profile ?? null);
  }, [fetchProfileData, setProfile]);

  if (fetchProfileError) {
    throw fetchProfileError;
  }

  if (updateProfileError && updateProfileError.message !== "incorrect_credentials") {
    // TODO: Actually handle real errors
    throw updateProfileError;
  }

  if (fetchProfileLoading) {
    return <Loading kind="block" />;
  }

  const onSubmit = async (event: FormEvent<HTMLFormElement>): Promise<void> => {
    event.preventDefault();
    await updateProfile({variables: {input: {id, publicName}}});
  };
  const onChangePublicName = (event: ChangeEvent<HTMLInputElement>): void => {
    setPublicName(event.target.value);
  };

  return <form id="ProfileForm" className="row g-3" onSubmit={onSubmit}>
    <Field
      type="text"
      scope="ProfileForm"
      property="publicName"
      label="Public Name"
      hasValidated={false}
      inputAttributes={{
        readOnly: updateProfileLoading,
        onChange: onChangePublicName,
        value: publicName,
      }}
    />
    <section>
      <button disabled={updateProfileLoading} type="submit" className="btn btn-primary">
        Save
      </button>
    </section>
  </form>;
}
