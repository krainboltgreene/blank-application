/* tslint:disable */
/* eslint-disable */
// @generated
// This file was automatically generated and should not be edited.

import { ProfileChangeset } from "./../../../../../globalTypes";

// ====================================================
// GraphQL mutation operation: UpdateProfileMutation
// ====================================================

export interface UpdateProfileMutation_updateProfile {
  readonly __typename: "Profile";
  readonly id: string;
  readonly publicName: string | null;
}

export interface UpdateProfileMutation {
  /**
   * Update an existing profile
   */
  readonly updateProfile: UpdateProfileMutation_updateProfile | null;
}

export interface UpdateProfileMutationVariables {
  readonly input: ProfileChangeset;
}
