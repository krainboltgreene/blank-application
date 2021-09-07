import { GraphQLResolveInfo, GraphQLScalarType, GraphQLScalarTypeConfig } from 'graphql';
export type Maybe<T> = T | null;
export type Exact<T extends { [key: string]: unknown }> = { [K in keyof T]: T[K] };
export type MakeOptional<T, K extends keyof T> = Omit<T, K> & { [SubKey in K]?: Maybe<T[SubKey]> };
export type MakeMaybe<T, K extends keyof T> = Omit<T, K> & { [SubKey in K]: Maybe<T[SubKey]> };
export type RequireFields<T, K extends keyof T> = { [X in Exclude<keyof T, K>]?: T[X] } & { [P in K]-?: NonNullable<T[P]> };
/** All built-in and custom scalars, mapped to their actual values */
export type Scalars = {
  ID: string;
  String: string;
  Boolean: boolean;
  Int: number;
  Float: number;
  /**
   * The `Naive DateTime` scalar type represents a naive date and time without
   * timezone. The DateTime appears in a JSON response as an ISO8601 formatted
   * string.
   */
  NaiveDateTime: any;
};

export type Account = {
  __typename?: 'Account';
  id: Scalars['ID'];
  emailAddress: Scalars['String'];
  username?: Maybe<Scalars['String']>;
  insertedAt: Scalars['NaiveDateTime'];
  updatedAt: Scalars['NaiveDateTime'];
  organizationMemberships?: Maybe<Array<OrganizationMembership>>;
  organizations?: Maybe<Array<Maybe<Organization>>>;
  settings: Settings;
  profile: Profile;
};

export type AccountChangeset = {
  id: Scalars['ID'];
  username?: Maybe<Scalars['String']>;
  emailAddress?: Maybe<Scalars['String']>;
  password?: Maybe<Scalars['String']>;
};

export type AccountConfirmation = {
  confirmationSecret: Scalars['String'];
  password: Scalars['String'];
};

export type Identity = {
  id: Scalars['ID'];
};

export type ListParameters = {
  limit?: Maybe<Scalars['Int']>;
};

export type NewAccount = {
  username?: Maybe<Scalars['String']>;
  emailAddress: Scalars['String'];
  password?: Maybe<Scalars['String']>;
};

export type NewOrganization = {
  name?: Maybe<Scalars['String']>;
};

export type NewPermission = {
  name?: Maybe<Scalars['String']>;
};

export type NewSession = {
  emailAddress: Scalars['String'];
  password: Scalars['String'];
};

export type Organization = {
  __typename?: 'Organization';
  id: Scalars['ID'];
  name: Scalars['String'];
  slug: Scalars['String'];
  insertedAt: Scalars['NaiveDateTime'];
  updatedAt: Scalars['NaiveDateTime'];
  accounts?: Maybe<Array<Account>>;
  organizationPermissions?: Maybe<Array<OrganizationPermission>>;
  permissions?: Maybe<Array<Permission>>;
};

export type OrganizationChangeset = {
  id: Scalars['ID'];
  name?: Maybe<Scalars['String']>;
};

export type OrganizationMembership = {
  __typename?: 'OrganizationMembership';
  insertedAt: Scalars['NaiveDateTime'];
  updatedAt: Scalars['NaiveDateTime'];
  account: Account;
  organizationPermissions?: Maybe<Array<OrganizationPermission>>;
  organization: Organization;
};

export type OrganizationPermission = {
  __typename?: 'OrganizationPermission';
  insertedAt: Scalars['NaiveDateTime'];
  updatedAt: Scalars['NaiveDateTime'];
  permission: Permission;
  organization: Organization;
};

export type Permission = {
  __typename?: 'Permission';
  id: Scalars['ID'];
  name: Scalars['String'];
  slug: Scalars['String'];
  insertedAt: Scalars['NaiveDateTime'];
  updatedAt: Scalars['NaiveDateTime'];
  organizationPermissions?: Maybe<Array<OrganizationPermission>>;
};

export type PermissionChangeset = {
  id: Scalars['ID'];
  name?: Maybe<Scalars['String']>;
};

export type Profile = {
  __typename?: 'Profile';
  id: Scalars['ID'];
  publicName?: Maybe<Scalars['String']>;
};

export type ProfileChangeset = {
  id: Scalars['ID'];
  publicName?: Maybe<Scalars['String']>;
};

export type RootMutationType = {
  __typename?: 'RootMutationType';
  /** Create a new account */
  createAccount?: Maybe<Account>;
  /** Update an existing account */
  updateAccount?: Maybe<Account>;
  /** Confirm an existing account */
  confirmAccount?: Maybe<Account>;
  /** Permanently delete an existing account */
  destroyAccount?: Maybe<Account>;
  /** Create a new organization */
  createOrganization?: Maybe<Organization>;
  /** Update an existing organization */
  updateOrganization?: Maybe<Organization>;
  /** Permanently delete an existing organization */
  destroyOrganization?: Maybe<Organization>;
  /** Create a new permission */
  createPermission?: Maybe<Permission>;
  /** Update an existing permission */
  updatePermission?: Maybe<Permission>;
  /** Permanently delete an existing permission */
  destroyPermission?: Maybe<Permission>;
  /** Update an existing settings */
  updateSettings?: Maybe<Settings>;
  /** Update an existing profile */
  updateProfile?: Maybe<Profile>;
  /** Create a new session */
  createSession?: Maybe<Session>;
  /** Permanently delete an existing session */
  destroySession?: Maybe<Session>;
};


export type RootMutationTypeCreateAccountArgs = {
  input: NewAccount;
};


export type RootMutationTypeUpdateAccountArgs = {
  input: AccountChangeset;
};


export type RootMutationTypeConfirmAccountArgs = {
  input: AccountConfirmation;
};


export type RootMutationTypeDestroyAccountArgs = {
  input: Identity;
};


export type RootMutationTypeCreateOrganizationArgs = {
  input: NewOrganization;
};


export type RootMutationTypeUpdateOrganizationArgs = {
  input: OrganizationChangeset;
};


export type RootMutationTypeDestroyOrganizationArgs = {
  input: Identity;
};


export type RootMutationTypeCreatePermissionArgs = {
  input: NewPermission;
};


export type RootMutationTypeUpdatePermissionArgs = {
  input: PermissionChangeset;
};


export type RootMutationTypeDestroyPermissionArgs = {
  input: Identity;
};


export type RootMutationTypeUpdateSettingsArgs = {
  input: SettingsChangeset;
};


export type RootMutationTypeUpdateProfileArgs = {
  input: ProfileChangeset;
};


export type RootMutationTypeCreateSessionArgs = {
  input: NewSession;
};

export type RootQueryType = {
  __typename?: 'RootQueryType';
  /** Get all accounts */
  accounts?: Maybe<Array<Maybe<Account>>>;
  /** Get an account by id */
  account?: Maybe<Account>;
  /** Get all organizations */
  organizations?: Maybe<Array<Maybe<Organization>>>;
  /** Get an organization by id */
  organization?: Maybe<Organization>;
  /** Get all permissions */
  permissions?: Maybe<Array<Maybe<Permission>>>;
  /** Get an permission by id */
  permission?: Maybe<Permission>;
  /** Get current session */
  session?: Maybe<Session>;
};


export type RootQueryTypeAccountsArgs = {
  input?: Maybe<ListParameters>;
};


export type RootQueryTypeAccountArgs = {
  input: Identity;
};


export type RootQueryTypeOrganizationsArgs = {
  input?: Maybe<ListParameters>;
};


export type RootQueryTypeOrganizationArgs = {
  input: Identity;
};


export type RootQueryTypePermissionsArgs = {
  input?: Maybe<ListParameters>;
};


export type RootQueryTypePermissionArgs = {
  input: Identity;
};

export type RootSubscriptionType = {
  __typename?: 'RootSubscriptionType';
  /** When a new account is created */
  accountCreated?: Maybe<Account>;
  /** When a new organization is created */
  organizationCreated?: Maybe<Organization>;
  /** When a new permission is created */
  permissionCreated?: Maybe<Permission>;
  /** When a new session is created */
  sessionCreated?: Maybe<Session>;
};


export type RootSubscriptionTypeAccountCreatedArgs = {
  id: Scalars['ID'];
};


export type RootSubscriptionTypeOrganizationCreatedArgs = {
  id: Scalars['ID'];
};


export type RootSubscriptionTypePermissionCreatedArgs = {
  id: Scalars['ID'];
};


export type RootSubscriptionTypeSessionCreatedArgs = {
  id: Scalars['ID'];
};

export type Session = {
  __typename?: 'Session';
  id?: Maybe<Scalars['String']>;
  account: Account;
};

export type Settings = {
  __typename?: 'Settings';
  id: Scalars['ID'];
  lightMode: Scalars['Boolean'];
};

export type SettingsChangeset = {
  id: Scalars['ID'];
  lightMode?: Maybe<Scalars['Boolean']>;
};

export type FetchSessionQueryVariables = Exact<{ [key: string]: never; }>;


export type FetchSessionQuery = { __typename?: 'RootQueryType', session?: Maybe<{ __typename?: 'Session', id?: Maybe<string> }> };

export type FetchAccountQueryVariables = Exact<{
  input: Identity;
}>;


export type FetchAccountQuery = { __typename?: 'RootQueryType', account?: Maybe<{ __typename?: 'Account', id: string, username?: Maybe<string>, emailAddress: string }> };

export type UpdateAccountMutationVariables = Exact<{
  input: AccountChangeset;
}>;


export type UpdateAccountMutation = { __typename?: 'RootMutationType', updateAccount?: Maybe<{ __typename?: 'Account', id: string, emailAddress: string, username?: Maybe<string> }> };

export type ConfirmAccountMutationVariables = Exact<{
  input: AccountConfirmation;
}>;


export type ConfirmAccountMutation = { __typename?: 'RootMutationType', confirmAccount?: Maybe<{ __typename?: 'Account', id: string }> };

export type CreateSessionMutationVariables = Exact<{
  input: NewSession;
}>;


export type CreateSessionMutation = { __typename?: 'RootMutationType', createSession?: Maybe<{ __typename?: 'Session', id?: Maybe<string> }> };

export type DestroySessionMutationVariables = Exact<{ [key: string]: never; }>;


export type DestroySessionMutation = { __typename?: 'RootMutationType', destroySession?: Maybe<{ __typename?: 'Session', id?: Maybe<string> }> };

export type CreateAccountMutationVariables = Exact<{
  input: NewAccount;
}>;


export type CreateAccountMutation = { __typename?: 'RootMutationType', createAccount?: Maybe<{ __typename?: 'Account', id: string, emailAddress: string }> };

export type FetchYourProfileQueryVariables = Exact<{ [key: string]: never; }>;


export type FetchYourProfileQuery = { __typename?: 'RootQueryType', session?: Maybe<{ __typename?: 'Session', id?: Maybe<string>, account: { __typename?: 'Account', id: string, profile: { __typename?: 'Profile', id: string, publicName?: Maybe<string> } } }> };

export type UpdateProfileMutationVariables = Exact<{
  input: ProfileChangeset;
}>;


export type UpdateProfileMutation = { __typename?: 'RootMutationType', updateProfile?: Maybe<{ __typename?: 'Profile', id: string, publicName?: Maybe<string> }> };

export type FetchYourSettingsQueryVariables = Exact<{ [key: string]: never; }>;


export type FetchYourSettingsQuery = { __typename?: 'RootQueryType', session?: Maybe<{ __typename?: 'Session', id?: Maybe<string>, account: { __typename?: 'Account', id: string, settings: { __typename?: 'Settings', id: string, lightMode: boolean } } }> };

export type UpdateSettingsMutationVariables = Exact<{
  input: SettingsChangeset;
}>;


export type UpdateSettingsMutation = { __typename?: 'RootMutationType', updateSettings?: Maybe<{ __typename?: 'Settings', id: string, lightMode: boolean }> };



export type ResolverTypeWrapper<T> = Promise<T> | T;


export type ResolverWithResolve<TResult, TParent, TContext, TArgs> = {
  resolve: ResolverFn<TResult, TParent, TContext, TArgs>;
};
export type Resolver<TResult, TParent = {}, TContext = {}, TArgs = {}> = ResolverFn<TResult, TParent, TContext, TArgs> | ResolverWithResolve<TResult, TParent, TContext, TArgs>;

export type ResolverFn<TResult, TParent, TContext, TArgs> = (
  parent: TParent,
  args: TArgs,
  context: TContext,
  info: GraphQLResolveInfo
) => Promise<TResult> | TResult;

export type SubscriptionSubscribeFn<TResult, TParent, TContext, TArgs> = (
  parent: TParent,
  args: TArgs,
  context: TContext,
  info: GraphQLResolveInfo
) => AsyncIterator<TResult> | Promise<AsyncIterator<TResult>>;

export type SubscriptionResolveFn<TResult, TParent, TContext, TArgs> = (
  parent: TParent,
  args: TArgs,
  context: TContext,
  info: GraphQLResolveInfo
) => TResult | Promise<TResult>;

export interface SubscriptionSubscriberObject<TResult, TKey extends string, TParent, TContext, TArgs> {
  subscribe: SubscriptionSubscribeFn<{ [key in TKey]: TResult }, TParent, TContext, TArgs>;
  resolve?: SubscriptionResolveFn<TResult, { [key in TKey]: TResult }, TContext, TArgs>;
}

export interface SubscriptionResolverObject<TResult, TParent, TContext, TArgs> {
  subscribe: SubscriptionSubscribeFn<any, TParent, TContext, TArgs>;
  resolve: SubscriptionResolveFn<TResult, any, TContext, TArgs>;
}

export type SubscriptionObject<TResult, TKey extends string, TParent, TContext, TArgs> =
  | SubscriptionSubscriberObject<TResult, TKey, TParent, TContext, TArgs>
  | SubscriptionResolverObject<TResult, TParent, TContext, TArgs>;

export type SubscriptionResolver<TResult, TKey extends string, TParent = {}, TContext = {}, TArgs = {}> =
  | ((...args: any[]) => SubscriptionObject<TResult, TKey, TParent, TContext, TArgs>)
  | SubscriptionObject<TResult, TKey, TParent, TContext, TArgs>;

export type TypeResolveFn<TTypes, TParent = {}, TContext = {}> = (
  parent: TParent,
  context: TContext,
  info: GraphQLResolveInfo
) => Maybe<TTypes> | Promise<Maybe<TTypes>>;

export type IsTypeOfResolverFn<T = {}, TContext = {}> = (obj: T, context: TContext, info: GraphQLResolveInfo) => boolean | Promise<boolean>;

export type NextResolverFn<T> = () => Promise<T>;

export type DirectiveResolverFn<TResult = {}, TParent = {}, TContext = {}, TArgs = {}> = (
  next: NextResolverFn<TResult>,
  parent: TParent,
  args: TArgs,
  context: TContext,
  info: GraphQLResolveInfo
) => TResult | Promise<TResult>;

/** Mapping between all available schema types and the resolvers types */
export type ResolversTypes = {
  Account: ResolverTypeWrapper<Account>;
  ID: ResolverTypeWrapper<Scalars['ID']>;
  String: ResolverTypeWrapper<Scalars['String']>;
  AccountChangeset: AccountChangeset;
  AccountConfirmation: AccountConfirmation;
  Identity: Identity;
  ListParameters: ListParameters;
  Int: ResolverTypeWrapper<Scalars['Int']>;
  NaiveDateTime: ResolverTypeWrapper<Scalars['NaiveDateTime']>;
  NewAccount: NewAccount;
  NewOrganization: NewOrganization;
  NewPermission: NewPermission;
  NewSession: NewSession;
  Organization: ResolverTypeWrapper<Organization>;
  OrganizationChangeset: OrganizationChangeset;
  OrganizationMembership: ResolverTypeWrapper<OrganizationMembership>;
  OrganizationPermission: ResolverTypeWrapper<OrganizationPermission>;
  Permission: ResolverTypeWrapper<Permission>;
  PermissionChangeset: PermissionChangeset;
  Profile: ResolverTypeWrapper<Profile>;
  ProfileChangeset: ProfileChangeset;
  RootMutationType: ResolverTypeWrapper<{}>;
  RootQueryType: ResolverTypeWrapper<{}>;
  RootSubscriptionType: ResolverTypeWrapper<{}>;
  Session: ResolverTypeWrapper<Session>;
  Settings: ResolverTypeWrapper<Settings>;
  Boolean: ResolverTypeWrapper<Scalars['Boolean']>;
  SettingsChangeset: SettingsChangeset;
};

/** Mapping between all available schema types and the resolvers parents */
export type ResolversParentTypes = {
  Account: Account;
  ID: Scalars['ID'];
  String: Scalars['String'];
  AccountChangeset: AccountChangeset;
  AccountConfirmation: AccountConfirmation;
  Identity: Identity;
  ListParameters: ListParameters;
  Int: Scalars['Int'];
  NaiveDateTime: Scalars['NaiveDateTime'];
  NewAccount: NewAccount;
  NewOrganization: NewOrganization;
  NewPermission: NewPermission;
  NewSession: NewSession;
  Organization: Organization;
  OrganizationChangeset: OrganizationChangeset;
  OrganizationMembership: OrganizationMembership;
  OrganizationPermission: OrganizationPermission;
  Permission: Permission;
  PermissionChangeset: PermissionChangeset;
  Profile: Profile;
  ProfileChangeset: ProfileChangeset;
  RootMutationType: {};
  RootQueryType: {};
  RootSubscriptionType: {};
  Session: Session;
  Settings: Settings;
  Boolean: Scalars['Boolean'];
  SettingsChangeset: SettingsChangeset;
};

export type AccountResolvers<ContextType = any, ParentType extends ResolversParentTypes['Account'] = ResolversParentTypes['Account']> = {
  id?: Resolver<ResolversTypes['ID'], ParentType, ContextType>;
  emailAddress?: Resolver<ResolversTypes['String'], ParentType, ContextType>;
  username?: Resolver<Maybe<ResolversTypes['String']>, ParentType, ContextType>;
  insertedAt?: Resolver<ResolversTypes['NaiveDateTime'], ParentType, ContextType>;
  updatedAt?: Resolver<ResolversTypes['NaiveDateTime'], ParentType, ContextType>;
  organizationMemberships?: Resolver<Maybe<Array<ResolversTypes['OrganizationMembership']>>, ParentType, ContextType>;
  organizations?: Resolver<Maybe<Array<Maybe<ResolversTypes['Organization']>>>, ParentType, ContextType>;
  settings?: Resolver<ResolversTypes['Settings'], ParentType, ContextType>;
  profile?: Resolver<ResolversTypes['Profile'], ParentType, ContextType>;
  __isTypeOf?: IsTypeOfResolverFn<ParentType, ContextType>;
};

export interface NaiveDateTimeScalarConfig extends GraphQLScalarTypeConfig<ResolversTypes['NaiveDateTime'], any> {
  name: 'NaiveDateTime';
}

export type OrganizationResolvers<ContextType = any, ParentType extends ResolversParentTypes['Organization'] = ResolversParentTypes['Organization']> = {
  id?: Resolver<ResolversTypes['ID'], ParentType, ContextType>;
  name?: Resolver<ResolversTypes['String'], ParentType, ContextType>;
  slug?: Resolver<ResolversTypes['String'], ParentType, ContextType>;
  insertedAt?: Resolver<ResolversTypes['NaiveDateTime'], ParentType, ContextType>;
  updatedAt?: Resolver<ResolversTypes['NaiveDateTime'], ParentType, ContextType>;
  accounts?: Resolver<Maybe<Array<ResolversTypes['Account']>>, ParentType, ContextType>;
  organizationPermissions?: Resolver<Maybe<Array<ResolversTypes['OrganizationPermission']>>, ParentType, ContextType>;
  permissions?: Resolver<Maybe<Array<ResolversTypes['Permission']>>, ParentType, ContextType>;
  __isTypeOf?: IsTypeOfResolverFn<ParentType, ContextType>;
};

export type OrganizationMembershipResolvers<ContextType = any, ParentType extends ResolversParentTypes['OrganizationMembership'] = ResolversParentTypes['OrganizationMembership']> = {
  insertedAt?: Resolver<ResolversTypes['NaiveDateTime'], ParentType, ContextType>;
  updatedAt?: Resolver<ResolversTypes['NaiveDateTime'], ParentType, ContextType>;
  account?: Resolver<ResolversTypes['Account'], ParentType, ContextType>;
  organizationPermissions?: Resolver<Maybe<Array<ResolversTypes['OrganizationPermission']>>, ParentType, ContextType>;
  organization?: Resolver<ResolversTypes['Organization'], ParentType, ContextType>;
  __isTypeOf?: IsTypeOfResolverFn<ParentType, ContextType>;
};

export type OrganizationPermissionResolvers<ContextType = any, ParentType extends ResolversParentTypes['OrganizationPermission'] = ResolversParentTypes['OrganizationPermission']> = {
  insertedAt?: Resolver<ResolversTypes['NaiveDateTime'], ParentType, ContextType>;
  updatedAt?: Resolver<ResolversTypes['NaiveDateTime'], ParentType, ContextType>;
  permission?: Resolver<ResolversTypes['Permission'], ParentType, ContextType>;
  organization?: Resolver<ResolversTypes['Organization'], ParentType, ContextType>;
  __isTypeOf?: IsTypeOfResolverFn<ParentType, ContextType>;
};

export type PermissionResolvers<ContextType = any, ParentType extends ResolversParentTypes['Permission'] = ResolversParentTypes['Permission']> = {
  id?: Resolver<ResolversTypes['ID'], ParentType, ContextType>;
  name?: Resolver<ResolversTypes['String'], ParentType, ContextType>;
  slug?: Resolver<ResolversTypes['String'], ParentType, ContextType>;
  insertedAt?: Resolver<ResolversTypes['NaiveDateTime'], ParentType, ContextType>;
  updatedAt?: Resolver<ResolversTypes['NaiveDateTime'], ParentType, ContextType>;
  organizationPermissions?: Resolver<Maybe<Array<ResolversTypes['OrganizationPermission']>>, ParentType, ContextType>;
  __isTypeOf?: IsTypeOfResolverFn<ParentType, ContextType>;
};

export type ProfileResolvers<ContextType = any, ParentType extends ResolversParentTypes['Profile'] = ResolversParentTypes['Profile']> = {
  id?: Resolver<ResolversTypes['ID'], ParentType, ContextType>;
  publicName?: Resolver<Maybe<ResolversTypes['String']>, ParentType, ContextType>;
  __isTypeOf?: IsTypeOfResolverFn<ParentType, ContextType>;
};

export type RootMutationTypeResolvers<ContextType = any, ParentType extends ResolversParentTypes['RootMutationType'] = ResolversParentTypes['RootMutationType']> = {
  createAccount?: Resolver<Maybe<ResolversTypes['Account']>, ParentType, ContextType, RequireFields<RootMutationTypeCreateAccountArgs, 'input'>>;
  updateAccount?: Resolver<Maybe<ResolversTypes['Account']>, ParentType, ContextType, RequireFields<RootMutationTypeUpdateAccountArgs, 'input'>>;
  confirmAccount?: Resolver<Maybe<ResolversTypes['Account']>, ParentType, ContextType, RequireFields<RootMutationTypeConfirmAccountArgs, 'input'>>;
  destroyAccount?: Resolver<Maybe<ResolversTypes['Account']>, ParentType, ContextType, RequireFields<RootMutationTypeDestroyAccountArgs, 'input'>>;
  createOrganization?: Resolver<Maybe<ResolversTypes['Organization']>, ParentType, ContextType, RequireFields<RootMutationTypeCreateOrganizationArgs, 'input'>>;
  updateOrganization?: Resolver<Maybe<ResolversTypes['Organization']>, ParentType, ContextType, RequireFields<RootMutationTypeUpdateOrganizationArgs, 'input'>>;
  destroyOrganization?: Resolver<Maybe<ResolversTypes['Organization']>, ParentType, ContextType, RequireFields<RootMutationTypeDestroyOrganizationArgs, 'input'>>;
  createPermission?: Resolver<Maybe<ResolversTypes['Permission']>, ParentType, ContextType, RequireFields<RootMutationTypeCreatePermissionArgs, 'input'>>;
  updatePermission?: Resolver<Maybe<ResolversTypes['Permission']>, ParentType, ContextType, RequireFields<RootMutationTypeUpdatePermissionArgs, 'input'>>;
  destroyPermission?: Resolver<Maybe<ResolversTypes['Permission']>, ParentType, ContextType, RequireFields<RootMutationTypeDestroyPermissionArgs, 'input'>>;
  updateSettings?: Resolver<Maybe<ResolversTypes['Settings']>, ParentType, ContextType, RequireFields<RootMutationTypeUpdateSettingsArgs, 'input'>>;
  updateProfile?: Resolver<Maybe<ResolversTypes['Profile']>, ParentType, ContextType, RequireFields<RootMutationTypeUpdateProfileArgs, 'input'>>;
  createSession?: Resolver<Maybe<ResolversTypes['Session']>, ParentType, ContextType, RequireFields<RootMutationTypeCreateSessionArgs, 'input'>>;
  destroySession?: Resolver<Maybe<ResolversTypes['Session']>, ParentType, ContextType>;
};

export type RootQueryTypeResolvers<ContextType = any, ParentType extends ResolversParentTypes['RootQueryType'] = ResolversParentTypes['RootQueryType']> = {
  accounts?: Resolver<Maybe<Array<Maybe<ResolversTypes['Account']>>>, ParentType, ContextType, RequireFields<RootQueryTypeAccountsArgs, never>>;
  account?: Resolver<Maybe<ResolversTypes['Account']>, ParentType, ContextType, RequireFields<RootQueryTypeAccountArgs, 'input'>>;
  organizations?: Resolver<Maybe<Array<Maybe<ResolversTypes['Organization']>>>, ParentType, ContextType, RequireFields<RootQueryTypeOrganizationsArgs, never>>;
  organization?: Resolver<Maybe<ResolversTypes['Organization']>, ParentType, ContextType, RequireFields<RootQueryTypeOrganizationArgs, 'input'>>;
  permissions?: Resolver<Maybe<Array<Maybe<ResolversTypes['Permission']>>>, ParentType, ContextType, RequireFields<RootQueryTypePermissionsArgs, never>>;
  permission?: Resolver<Maybe<ResolversTypes['Permission']>, ParentType, ContextType, RequireFields<RootQueryTypePermissionArgs, 'input'>>;
  session?: Resolver<Maybe<ResolversTypes['Session']>, ParentType, ContextType>;
};

export type RootSubscriptionTypeResolvers<ContextType = any, ParentType extends ResolversParentTypes['RootSubscriptionType'] = ResolversParentTypes['RootSubscriptionType']> = {
  accountCreated?: SubscriptionResolver<Maybe<ResolversTypes['Account']>, "accountCreated", ParentType, ContextType, RequireFields<RootSubscriptionTypeAccountCreatedArgs, 'id'>>;
  organizationCreated?: SubscriptionResolver<Maybe<ResolversTypes['Organization']>, "organizationCreated", ParentType, ContextType, RequireFields<RootSubscriptionTypeOrganizationCreatedArgs, 'id'>>;
  permissionCreated?: SubscriptionResolver<Maybe<ResolversTypes['Permission']>, "permissionCreated", ParentType, ContextType, RequireFields<RootSubscriptionTypePermissionCreatedArgs, 'id'>>;
  sessionCreated?: SubscriptionResolver<Maybe<ResolversTypes['Session']>, "sessionCreated", ParentType, ContextType, RequireFields<RootSubscriptionTypeSessionCreatedArgs, 'id'>>;
};

export type SessionResolvers<ContextType = any, ParentType extends ResolversParentTypes['Session'] = ResolversParentTypes['Session']> = {
  id?: Resolver<Maybe<ResolversTypes['String']>, ParentType, ContextType>;
  account?: Resolver<ResolversTypes['Account'], ParentType, ContextType>;
  __isTypeOf?: IsTypeOfResolverFn<ParentType, ContextType>;
};

export type SettingsResolvers<ContextType = any, ParentType extends ResolversParentTypes['Settings'] = ResolversParentTypes['Settings']> = {
  id?: Resolver<ResolversTypes['ID'], ParentType, ContextType>;
  lightMode?: Resolver<ResolversTypes['Boolean'], ParentType, ContextType>;
  __isTypeOf?: IsTypeOfResolverFn<ParentType, ContextType>;
};

export type Resolvers<ContextType = any> = {
  Account?: AccountResolvers<ContextType>;
  NaiveDateTime?: GraphQLScalarType;
  Organization?: OrganizationResolvers<ContextType>;
  OrganizationMembership?: OrganizationMembershipResolvers<ContextType>;
  OrganizationPermission?: OrganizationPermissionResolvers<ContextType>;
  Permission?: PermissionResolvers<ContextType>;
  Profile?: ProfileResolvers<ContextType>;
  RootMutationType?: RootMutationTypeResolvers<ContextType>;
  RootQueryType?: RootQueryTypeResolvers<ContextType>;
  RootSubscriptionType?: RootSubscriptionTypeResolvers<ContextType>;
  Session?: SessionResolvers<ContextType>;
  Settings?: SettingsResolvers<ContextType>;
};

