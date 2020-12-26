/* tslint:disable */
/* eslint-disable */
// @generated
// This file was automatically generated and should not be edited.

// ====================================================
// GraphQL mutation operation: DestroySessionMutation
// ====================================================

export interface DestroySessionMutation_destroySession {
  readonly __typename: "Session";
  readonly id: string | null;
}

export interface DestroySessionMutation {
  /**
   * Permanently delete an existing session
   */
  readonly destroySession: DestroySessionMutation_destroySession | null;
}
