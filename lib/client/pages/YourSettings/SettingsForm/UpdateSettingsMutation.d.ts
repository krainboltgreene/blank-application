/* tslint:disable */
/* eslint-disable */
// @generated
// This file was automatically generated and should not be edited.

import { SettingsChangeset } from "./../../../../../globalTypes";

// ====================================================
// GraphQL mutation operation: UpdateSettingsMutation
// ====================================================

export interface UpdateSettingsMutation_updateSettings {
  readonly __typename: "Settings";
  readonly id: string;
  readonly lightMode: boolean;
}

export interface UpdateSettingsMutation {
  /**
   * Update an existing settings
   */
  readonly updateSettings: UpdateSettingsMutation_updateSettings | null;
}

export interface UpdateSettingsMutationVariables {
  readonly input: SettingsChangeset;
}
