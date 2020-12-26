/* tslint:disable */
/* eslint-disable */
// @generated
// This file was automatically generated and should not be edited.

// ====================================================
// GraphQL query operation: fetchSessionQuery
// ====================================================

export interface fetchSessionQuery_session {
  readonly __typename: "Session";
  readonly id: string | null;
}

export interface fetchSessionQuery {
  /**
   * Get current session
   */
  readonly session: fetchSessionQuery_session | null;
}
