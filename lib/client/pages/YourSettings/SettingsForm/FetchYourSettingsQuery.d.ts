/* tslint:disable */
/* eslint-disable */
// @generated
// This file was automatically generated and should not be edited.

// ====================================================
// GraphQL query operation: FetchYourSettingsQuery
// ====================================================

export interface FetchYourSettingsQuery_session_account_settings {
  readonly __typename: "Settings";
  readonly id: string;
  readonly lightMode: boolean;
}

export interface FetchYourSettingsQuery_session_account {
  readonly __typename: "Account";
  readonly id: string;
  readonly settings: FetchYourSettingsQuery_session_account_settings;
}

export interface FetchYourSettingsQuery_session {
  readonly __typename: "Session";
  readonly id: string | null;
  readonly account: FetchYourSettingsQuery_session_account;
}

export interface FetchYourSettingsQuery {
  /**
   * Get current session
   */
  readonly session: FetchYourSettingsQuery_session | null;
}
