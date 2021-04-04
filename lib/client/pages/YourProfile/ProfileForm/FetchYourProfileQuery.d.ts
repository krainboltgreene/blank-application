/* tslint:disable */
/* eslint-disable */
// @generated
// This file was automatically generated and should not be edited.

// ====================================================
// GraphQL query operation: FetchYourProfileQuery
// ====================================================

export interface FetchYourProfileQuery_session_account_profile {
  readonly __typename: "Profile";
  readonly id: string;
  readonly publicName: string | null;
}

export interface FetchYourProfileQuery_session_account {
  readonly __typename: "Account";
  readonly id: string;
  readonly profile: FetchYourProfileQuery_session_account_profile;
}

export interface FetchYourProfileQuery_session {
  readonly __typename: "Session";
  readonly id: string | null;
  readonly account: FetchYourProfileQuery_session_account;
}

export interface FetchYourProfileQuery {
  /**
   * Get current session
   */
  readonly session: FetchYourProfileQuery_session | null;
}
