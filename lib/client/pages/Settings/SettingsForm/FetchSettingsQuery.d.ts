/* tslint:disable */
/* eslint-disable */
// @generated
// This file was automatically generated and should not be edited.

// ====================================================
// GraphQL query operation: FetchSettingsQuery
// ====================================================

export interface FetchSettingsQuery_session_account_settings {
  readonly __typename: "Settings";
  readonly id: string;
  readonly lightMode: boolean;
}

export interface FetchSettingsQuery_session_account {
  readonly __typename: "Account";
  readonly id: string;
  readonly settings: FetchSettingsQuery_session_account_settings;
}

export interface FetchSettingsQuery_session {
  readonly __typename: "Session";
  readonly id: string | null;
  readonly account: FetchSettingsQuery_session_account;
}

export interface FetchSettingsQuery {
  /**
   * Get current session
   */
  readonly session: FetchSettingsQuery_session | null;
}
