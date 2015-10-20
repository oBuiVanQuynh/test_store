# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20151020063426) do

  create_table "attachments", force: :cascade do |t|
    t.integer  "container_id",   limit: 4
    t.string   "container_type", limit: 30
    t.string   "filename",       limit: 255, default: "", null: false
    t.string   "disk_filename",  limit: 255, default: "", null: false
    t.integer  "filesize",       limit: 4,   default: 0,  null: false
    t.string   "content_type",   limit: 255, default: ""
    t.string   "digest",         limit: 40,  default: "", null: false
    t.integer  "downloads",      limit: 4,   default: 0,  null: false
    t.integer  "author_id",      limit: 4,   default: 0,  null: false
    t.datetime "created_on"
    t.string   "description",    limit: 255
    t.string   "disk_directory", limit: 255
  end

  add_index "attachments", ["author_id"], name: "index_attachments_on_author_id", using: :btree
  add_index "attachments", ["container_id", "container_type"], name: "index_attachments_on_container_id_and_container_type", using: :btree
  add_index "attachments", ["created_on"], name: "index_attachments_on_created_on", using: :btree

  create_table "auth_sources", force: :cascade do |t|
    t.string  "type",              limit: 30,  default: "",    null: false
    t.string  "name",              limit: 60,  default: "",    null: false
    t.string  "host",              limit: 60
    t.integer "port",              limit: 4
    t.string  "account",           limit: 255
    t.string  "account_password",  limit: 255, default: ""
    t.string  "base_dn",           limit: 255
    t.string  "attr_login",        limit: 30
    t.string  "attr_firstname",    limit: 30
    t.string  "attr_lastname",     limit: 30
    t.string  "attr_mail",         limit: 30
    t.boolean "onthefly_register",             default: false, null: false
    t.boolean "tls",                           default: false, null: false
    t.string  "filter",            limit: 255
    t.integer "timeout",           limit: 4
  end

  add_index "auth_sources", ["id", "type"], name: "index_auth_sources_on_id_and_type", using: :btree

  create_table "boards", force: :cascade do |t|
    t.integer "project_id",      limit: 4,                null: false
    t.string  "name",            limit: 255, default: "", null: false
    t.string  "description",     limit: 255
    t.integer "position",        limit: 4,   default: 1
    t.integer "topics_count",    limit: 4,   default: 0,  null: false
    t.integer "messages_count",  limit: 4,   default: 0,  null: false
    t.integer "last_message_id", limit: 4
    t.integer "parent_id",       limit: 4
  end

  add_index "boards", ["last_message_id"], name: "index_boards_on_last_message_id", using: :btree
  add_index "boards", ["project_id"], name: "boards_project_id", using: :btree

  create_table "changes", force: :cascade do |t|
    t.integer "changeset_id",  limit: 4,                  null: false
    t.string  "action",        limit: 1,     default: "", null: false
    t.text    "path",          limit: 65535,              null: false
    t.text    "from_path",     limit: 65535
    t.string  "from_revision", limit: 255
    t.string  "revision",      limit: 255
    t.string  "branch",        limit: 255
  end

  add_index "changes", ["changeset_id"], name: "changesets_changeset_id", using: :btree

  create_table "changeset_parents", id: false, force: :cascade do |t|
    t.integer "changeset_id", limit: 4, null: false
    t.integer "parent_id",    limit: 4, null: false
  end

  add_index "changeset_parents", ["changeset_id"], name: "changeset_parents_changeset_ids", using: :btree
  add_index "changeset_parents", ["parent_id"], name: "changeset_parents_parent_ids", using: :btree

  create_table "changesets", force: :cascade do |t|
    t.integer  "repository_id", limit: 4,          null: false
    t.string   "revision",      limit: 255,        null: false
    t.string   "committer",     limit: 255
    t.datetime "committed_on",                     null: false
    t.text     "comments",      limit: 4294967295
    t.date     "commit_date"
    t.string   "scmid",         limit: 255
    t.integer  "user_id",       limit: 4
  end

  add_index "changesets", ["committed_on"], name: "index_changesets_on_committed_on", using: :btree
  add_index "changesets", ["repository_id", "revision"], name: "changesets_repos_rev", unique: true, using: :btree
  add_index "changesets", ["repository_id", "scmid"], name: "changesets_repos_scmid", using: :btree
  add_index "changesets", ["repository_id"], name: "index_changesets_on_repository_id", using: :btree
  add_index "changesets", ["user_id"], name: "index_changesets_on_user_id", using: :btree

  create_table "changesets_issues", id: false, force: :cascade do |t|
    t.integer "changeset_id", limit: 4, null: false
    t.integer "issue_id",     limit: 4, null: false
  end

  add_index "changesets_issues", ["changeset_id", "issue_id"], name: "changesets_issues_ids", unique: true, using: :btree

  create_table "comments", force: :cascade do |t|
    t.string   "commented_type", limit: 30,    default: "", null: false
    t.integer  "commented_id",   limit: 4,     default: 0,  null: false
    t.integer  "author_id",      limit: 4,     default: 0,  null: false
    t.text     "comments",       limit: 65535
    t.datetime "created_on",                                null: false
    t.datetime "updated_on",                                null: false
  end

  add_index "comments", ["author_id"], name: "index_comments_on_author_id", using: :btree
  add_index "comments", ["commented_id", "commented_type"], name: "index_comments_on_commented_id_and_commented_type", using: :btree

  create_table "custom_fields", force: :cascade do |t|
    t.string  "type",            limit: 30,    default: "",    null: false
    t.string  "name",            limit: 30,    default: "",    null: false
    t.string  "field_format",    limit: 30,    default: "",    null: false
    t.text    "possible_values", limit: 65535
    t.string  "regexp",          limit: 255,   default: ""
    t.integer "min_length",      limit: 4
    t.integer "max_length",      limit: 4
    t.boolean "is_required",                   default: false, null: false
    t.boolean "is_for_all",                    default: false, null: false
    t.boolean "is_filter",                     default: false, null: false
    t.integer "position",        limit: 4,     default: 1
    t.boolean "searchable",                    default: false
    t.text    "default_value",   limit: 65535
    t.boolean "editable",                      default: true
    t.boolean "visible",                       default: true,  null: false
    t.boolean "multiple",                      default: false
    t.text    "format_store",    limit: 65535
    t.text    "description",     limit: 65535
  end

  add_index "custom_fields", ["id", "type"], name: "index_custom_fields_on_id_and_type", using: :btree

  create_table "custom_fields_projects", id: false, force: :cascade do |t|
    t.integer "custom_field_id", limit: 4, default: 0, null: false
    t.integer "project_id",      limit: 4, default: 0, null: false
  end

  add_index "custom_fields_projects", ["custom_field_id", "project_id"], name: "index_custom_fields_projects_on_custom_field_id_and_project_id", unique: true, using: :btree

  create_table "custom_fields_roles", id: false, force: :cascade do |t|
    t.integer "custom_field_id", limit: 4, null: false
    t.integer "role_id",         limit: 4, null: false
  end

  add_index "custom_fields_roles", ["custom_field_id", "role_id"], name: "custom_fields_roles_ids", unique: true, using: :btree

  create_table "custom_fields_trackers", id: false, force: :cascade do |t|
    t.integer "custom_field_id", limit: 4, default: 0, null: false
    t.integer "tracker_id",      limit: 4, default: 0, null: false
  end

  add_index "custom_fields_trackers", ["custom_field_id", "tracker_id"], name: "index_custom_fields_trackers_on_custom_field_id_and_tracker_id", unique: true, using: :btree

  create_table "custom_values", force: :cascade do |t|
    t.string  "customized_type", limit: 30,    default: "", null: false
    t.integer "customized_id",   limit: 4,     default: 0,  null: false
    t.integer "custom_field_id", limit: 4,     default: 0,  null: false
    t.text    "value",           limit: 65535
  end

  add_index "custom_values", ["custom_field_id"], name: "index_custom_values_on_custom_field_id", using: :btree
  add_index "custom_values", ["customized_type", "customized_id"], name: "custom_values_customized", using: :btree

  create_table "documents", force: :cascade do |t|
    t.integer  "project_id",  limit: 4,     default: 0,  null: false
    t.integer  "category_id", limit: 4,     default: 0,  null: false
    t.string   "title",       limit: 255,   default: "", null: false
    t.text     "description", limit: 65535
    t.datetime "created_on"
  end

  add_index "documents", ["category_id"], name: "index_documents_on_category_id", using: :btree
  add_index "documents", ["created_on"], name: "index_documents_on_created_on", using: :btree
  add_index "documents", ["project_id"], name: "documents_project_id", using: :btree

  create_table "email_addresses", force: :cascade do |t|
    t.integer  "user_id",    limit: 4,                   null: false
    t.string   "address",    limit: 255,                 null: false
    t.boolean  "is_default",             default: false, null: false
    t.boolean  "notify",                 default: true,  null: false
    t.datetime "created_on",                             null: false
    t.datetime "updated_on",                             null: false
  end

  add_index "email_addresses", ["user_id"], name: "index_email_addresses_on_user_id", using: :btree

  create_table "enabled_modules", force: :cascade do |t|
    t.integer "project_id", limit: 4
    t.string  "name",       limit: 255, null: false
  end

  add_index "enabled_modules", ["project_id"], name: "enabled_modules_project_id", using: :btree

  create_table "enumerations", force: :cascade do |t|
    t.string  "name",          limit: 30,  default: "",    null: false
    t.integer "position",      limit: 4,   default: 1
    t.boolean "is_default",                default: false, null: false
    t.string  "type",          limit: 255
    t.boolean "active",                    default: true,  null: false
    t.integer "project_id",    limit: 4
    t.integer "parent_id",     limit: 4
    t.string  "position_name", limit: 30
  end

  add_index "enumerations", ["id", "type"], name: "index_enumerations_on_id_and_type", using: :btree
  add_index "enumerations", ["project_id"], name: "index_enumerations_on_project_id", using: :btree

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",           limit: 255, null: false
    t.integer  "sluggable_id",   limit: 4,   null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope",          limit: 255
    t.datetime "created_at"
    t.datetime "deleted_at"
  end

  add_index "friendly_id_slugs", ["deleted_at"], name: "index_friendly_id_slugs_on_deleted_at", using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "groups_users", id: false, force: :cascade do |t|
    t.integer "group_id", limit: 4, null: false
    t.integer "user_id",  limit: 4, null: false
  end

  add_index "groups_users", ["group_id", "user_id"], name: "groups_users_ids", unique: true, using: :btree

  create_table "import_items", force: :cascade do |t|
    t.integer "import_id", limit: 4,     null: false
    t.integer "position",  limit: 4,     null: false
    t.integer "obj_id",    limit: 4
    t.text    "message",   limit: 65535
  end

  create_table "imports", force: :cascade do |t|
    t.string   "type",        limit: 255
    t.integer  "user_id",     limit: 4,                     null: false
    t.string   "filename",    limit: 255
    t.text     "settings",    limit: 65535
    t.integer  "total_items", limit: 4
    t.boolean  "finished",                  default: false, null: false
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  create_table "issue_categories", force: :cascade do |t|
    t.integer "project_id",     limit: 4,  default: 0,  null: false
    t.string  "name",           limit: 30, default: "", null: false
    t.integer "assigned_to_id", limit: 4
  end

  add_index "issue_categories", ["assigned_to_id"], name: "index_issue_categories_on_assigned_to_id", using: :btree
  add_index "issue_categories", ["project_id"], name: "issue_categories_project_id", using: :btree

  create_table "issue_relations", force: :cascade do |t|
    t.integer "issue_from_id", limit: 4,                null: false
    t.integer "issue_to_id",   limit: 4,                null: false
    t.string  "relation_type", limit: 255, default: "", null: false
    t.integer "delay",         limit: 4
  end

  add_index "issue_relations", ["issue_from_id", "issue_to_id"], name: "index_issue_relations_on_issue_from_id_and_issue_to_id", unique: true, using: :btree
  add_index "issue_relations", ["issue_from_id"], name: "index_issue_relations_on_issue_from_id", using: :btree
  add_index "issue_relations", ["issue_to_id"], name: "index_issue_relations_on_issue_to_id", using: :btree

  create_table "issue_statuses", force: :cascade do |t|
    t.string  "name",               limit: 30, default: "",    null: false
    t.boolean "is_closed",                     default: false, null: false
    t.integer "position",           limit: 4,  default: 1
    t.integer "default_done_ratio", limit: 4
  end

  add_index "issue_statuses", ["is_closed"], name: "index_issue_statuses_on_is_closed", using: :btree
  add_index "issue_statuses", ["position"], name: "index_issue_statuses_on_position", using: :btree

  create_table "issues", force: :cascade do |t|
    t.integer  "tracker_id",       limit: 4,                     null: false
    t.integer  "project_id",       limit: 4,                     null: false
    t.string   "subject",          limit: 255,   default: "",    null: false
    t.text     "description",      limit: 65535
    t.date     "due_date"
    t.integer  "category_id",      limit: 4
    t.integer  "status_id",        limit: 4,                     null: false
    t.integer  "assigned_to_id",   limit: 4
    t.integer  "priority_id",      limit: 4,                     null: false
    t.integer  "fixed_version_id", limit: 4
    t.integer  "author_id",        limit: 4,                     null: false
    t.integer  "lock_version",     limit: 4,     default: 0,     null: false
    t.datetime "created_on"
    t.datetime "updated_on"
    t.date     "start_date"
    t.integer  "done_ratio",       limit: 4,     default: 0,     null: false
    t.float    "estimated_hours",  limit: 24
    t.integer  "parent_id",        limit: 4
    t.integer  "root_id",          limit: 4
    t.integer  "lft",              limit: 4
    t.integer  "rgt",              limit: 4
    t.boolean  "is_private",                     default: false, null: false
    t.datetime "closed_on"
  end

  add_index "issues", ["assigned_to_id"], name: "index_issues_on_assigned_to_id", using: :btree
  add_index "issues", ["author_id"], name: "index_issues_on_author_id", using: :btree
  add_index "issues", ["category_id"], name: "index_issues_on_category_id", using: :btree
  add_index "issues", ["created_on"], name: "index_issues_on_created_on", using: :btree
  add_index "issues", ["fixed_version_id"], name: "index_issues_on_fixed_version_id", using: :btree
  add_index "issues", ["priority_id"], name: "index_issues_on_priority_id", using: :btree
  add_index "issues", ["project_id"], name: "issues_project_id", using: :btree
  add_index "issues", ["root_id", "lft", "rgt"], name: "index_issues_on_root_id_and_lft_and_rgt", using: :btree
  add_index "issues", ["status_id"], name: "index_issues_on_status_id", using: :btree
  add_index "issues", ["tracker_id"], name: "index_issues_on_tracker_id", using: :btree

  create_table "journal_details", force: :cascade do |t|
    t.integer "journal_id", limit: 4,     default: 0,  null: false
    t.string  "property",   limit: 30,    default: "", null: false
    t.string  "prop_key",   limit: 30,    default: "", null: false
    t.text    "old_value",  limit: 65535
    t.text    "value",      limit: 65535
  end

  add_index "journal_details", ["journal_id"], name: "journal_details_journal_id", using: :btree

  create_table "journals", force: :cascade do |t|
    t.integer  "journalized_id",   limit: 4,     default: 0,     null: false
    t.string   "journalized_type", limit: 30,    default: "",    null: false
    t.integer  "user_id",          limit: 4,     default: 0,     null: false
    t.text     "notes",            limit: 65535
    t.datetime "created_on",                                     null: false
    t.boolean  "private_notes",                  default: false, null: false
  end

  add_index "journals", ["created_on"], name: "index_journals_on_created_on", using: :btree
  add_index "journals", ["journalized_id", "journalized_type"], name: "journals_journalized_id", using: :btree
  add_index "journals", ["journalized_id"], name: "index_journals_on_journalized_id", using: :btree
  add_index "journals", ["user_id"], name: "index_journals_on_user_id", using: :btree

  create_table "member_roles", force: :cascade do |t|
    t.integer "member_id",      limit: 4, null: false
    t.integer "role_id",        limit: 4, null: false
    t.integer "inherited_from", limit: 4
  end

  add_index "member_roles", ["member_id"], name: "index_member_roles_on_member_id", using: :btree
  add_index "member_roles", ["role_id"], name: "index_member_roles_on_role_id", using: :btree

  create_table "members", force: :cascade do |t|
    t.integer  "user_id",           limit: 4, default: 0,     null: false
    t.integer  "project_id",        limit: 4, default: 0,     null: false
    t.datetime "created_on"
    t.boolean  "mail_notification",           default: false, null: false
  end

  add_index "members", ["project_id"], name: "index_members_on_project_id", using: :btree
  add_index "members", ["user_id", "project_id"], name: "index_members_on_user_id_and_project_id", unique: true, using: :btree
  add_index "members", ["user_id"], name: "index_members_on_user_id", using: :btree

  create_table "messages", force: :cascade do |t|
    t.integer  "board_id",      limit: 4,                     null: false
    t.integer  "parent_id",     limit: 4
    t.string   "subject",       limit: 255,   default: "",    null: false
    t.text     "content",       limit: 65535
    t.integer  "author_id",     limit: 4
    t.integer  "replies_count", limit: 4,     default: 0,     null: false
    t.integer  "last_reply_id", limit: 4
    t.datetime "created_on",                                  null: false
    t.datetime "updated_on",                                  null: false
    t.boolean  "locked",                      default: false
    t.integer  "sticky",        limit: 4,     default: 0
  end

  add_index "messages", ["author_id"], name: "index_messages_on_author_id", using: :btree
  add_index "messages", ["board_id"], name: "messages_board_id", using: :btree
  add_index "messages", ["created_on"], name: "index_messages_on_created_on", using: :btree
  add_index "messages", ["last_reply_id"], name: "index_messages_on_last_reply_id", using: :btree
  add_index "messages", ["parent_id"], name: "messages_parent_id", using: :btree

  create_table "news", force: :cascade do |t|
    t.integer  "project_id",     limit: 4
    t.string   "title",          limit: 60,    default: "", null: false
    t.string   "summary",        limit: 255,   default: ""
    t.text     "description",    limit: 65535
    t.integer  "author_id",      limit: 4,     default: 0,  null: false
    t.datetime "created_on"
    t.integer  "comments_count", limit: 4,     default: 0,  null: false
  end

  add_index "news", ["author_id"], name: "index_news_on_author_id", using: :btree
  add_index "news", ["created_on"], name: "index_news_on_created_on", using: :btree
  add_index "news", ["project_id"], name: "news_project_id", using: :btree

  create_table "open_id_authentication_associations", force: :cascade do |t|
    t.integer "issued",     limit: 4
    t.integer "lifetime",   limit: 4
    t.string  "handle",     limit: 255
    t.string  "assoc_type", limit: 255
    t.binary  "server_url", limit: 65535
    t.binary  "secret",     limit: 65535
  end

  create_table "open_id_authentication_nonces", force: :cascade do |t|
    t.integer "timestamp",  limit: 4,   null: false
    t.string  "server_url", limit: 255
    t.string  "salt",       limit: 255, null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string   "name",            limit: 255,   default: "",    null: false
    t.text     "description",     limit: 65535
    t.string   "homepage",        limit: 255,   default: ""
    t.boolean  "is_public",                     default: true,  null: false
    t.integer  "parent_id",       limit: 4
    t.datetime "created_on"
    t.datetime "updated_on"
    t.string   "identifier",      limit: 255
    t.integer  "status",          limit: 4,     default: 1,     null: false
    t.integer  "lft",             limit: 4
    t.integer  "rgt",             limit: 4
    t.boolean  "inherit_members",               default: false, null: false
  end

  add_index "projects", ["lft"], name: "index_projects_on_lft", using: :btree
  add_index "projects", ["rgt"], name: "index_projects_on_rgt", using: :btree

  create_table "projects_trackers", id: false, force: :cascade do |t|
    t.integer "project_id", limit: 4, default: 0, null: false
    t.integer "tracker_id", limit: 4, default: 0, null: false
  end

  add_index "projects_trackers", ["project_id", "tracker_id"], name: "projects_trackers_unique", unique: true, using: :btree
  add_index "projects_trackers", ["project_id"], name: "projects_trackers_project_id", using: :btree

  create_table "queries", force: :cascade do |t|
    t.integer "project_id",    limit: 4
    t.string  "name",          limit: 255,   default: "", null: false
    t.text    "filters",       limit: 65535
    t.integer "user_id",       limit: 4,     default: 0,  null: false
    t.text    "column_names",  limit: 65535
    t.text    "sort_criteria", limit: 65535
    t.string  "group_by",      limit: 255
    t.string  "type",          limit: 255
    t.integer "visibility",    limit: 4,     default: 0
    t.text    "options",       limit: 65535
  end

  add_index "queries", ["project_id"], name: "index_queries_on_project_id", using: :btree
  add_index "queries", ["user_id"], name: "index_queries_on_user_id", using: :btree

  create_table "queries_roles", id: false, force: :cascade do |t|
    t.integer "query_id", limit: 4, null: false
    t.integer "role_id",  limit: 4, null: false
  end

  add_index "queries_roles", ["query_id", "role_id"], name: "queries_roles_ids", unique: true, using: :btree

  create_table "repositories", force: :cascade do |t|
    t.integer  "project_id",    limit: 4,     default: 0,     null: false
    t.string   "url",           limit: 255,   default: "",    null: false
    t.string   "login",         limit: 60,    default: ""
    t.string   "password",      limit: 255,   default: ""
    t.string   "root_url",      limit: 255,   default: ""
    t.string   "type",          limit: 255
    t.string   "path_encoding", limit: 64
    t.string   "log_encoding",  limit: 64
    t.text     "extra_info",    limit: 65535
    t.string   "identifier",    limit: 255
    t.boolean  "is_default",                  default: false
    t.datetime "created_on"
  end

  add_index "repositories", ["project_id"], name: "index_repositories_on_project_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string  "name",                    limit: 30,    default: "",        null: false
    t.integer "position",                limit: 4,     default: 1
    t.boolean "assignable",                            default: true
    t.integer "builtin",                 limit: 4,     default: 0,         null: false
    t.text    "permissions",             limit: 65535
    t.string  "issues_visibility",       limit: 30,    default: "default", null: false
    t.string  "users_visibility",        limit: 30,    default: "all",     null: false
    t.string  "time_entries_visibility", limit: 30,    default: "all",     null: false
    t.boolean "all_roles_managed",                     default: true,      null: false
  end

  create_table "roles_managed_roles", id: false, force: :cascade do |t|
    t.integer "role_id",         limit: 4, null: false
    t.integer "managed_role_id", limit: 4, null: false
  end

  add_index "roles_managed_roles", ["role_id", "managed_role_id"], name: "index_roles_managed_roles_on_role_id_and_managed_role_id", unique: true, using: :btree

  create_table "settings", force: :cascade do |t|
    t.string   "name",       limit: 255,   default: "", null: false
    t.text     "value",      limit: 65535
    t.datetime "updated_on"
  end

  add_index "settings", ["name"], name: "index_settings_on_name", using: :btree

  create_table "spree_addresses", force: :cascade do |t|
    t.string   "firstname",         limit: 255
    t.string   "lastname",          limit: 255
    t.string   "address1",          limit: 255
    t.string   "address2",          limit: 255
    t.string   "city",              limit: 255
    t.string   "zipcode",           limit: 255
    t.string   "phone",             limit: 255
    t.string   "state_name",        limit: 255
    t.string   "alternative_phone", limit: 255
    t.string   "company",           limit: 255
    t.integer  "state_id",          limit: 4
    t.integer  "country_id",        limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "spree_addresses", ["country_id"], name: "index_spree_addresses_on_country_id", using: :btree
  add_index "spree_addresses", ["firstname"], name: "index_addresses_on_firstname", using: :btree
  add_index "spree_addresses", ["lastname"], name: "index_addresses_on_lastname", using: :btree
  add_index "spree_addresses", ["state_id"], name: "index_spree_addresses_on_state_id", using: :btree

  create_table "spree_adjustments", force: :cascade do |t|
    t.integer  "source_id",       limit: 4
    t.string   "source_type",     limit: 255
    t.integer  "adjustable_id",   limit: 4
    t.string   "adjustable_type", limit: 255
    t.decimal  "amount",                      precision: 10, scale: 2
    t.string   "label",           limit: 255
    t.boolean  "mandatory"
    t.boolean  "eligible",                                             default: true
    t.datetime "created_at",                                                           null: false
    t.datetime "updated_at",                                                           null: false
    t.string   "state",           limit: 255
    t.integer  "order_id",        limit: 4,                                            null: false
    t.boolean  "included",                                             default: false
  end

  add_index "spree_adjustments", ["adjustable_id", "adjustable_type"], name: "index_spree_adjustments_on_adjustable_id_and_adjustable_type", using: :btree
  add_index "spree_adjustments", ["eligible"], name: "index_spree_adjustments_on_eligible", using: :btree
  add_index "spree_adjustments", ["order_id"], name: "index_spree_adjustments_on_order_id", using: :btree
  add_index "spree_adjustments", ["source_id", "source_type"], name: "index_spree_adjustments_on_source_id_and_source_type", using: :btree

  create_table "spree_assets", force: :cascade do |t|
    t.integer  "viewable_id",             limit: 4
    t.string   "viewable_type",           limit: 255
    t.integer  "attachment_width",        limit: 4
    t.integer  "attachment_height",       limit: 4
    t.integer  "attachment_file_size",    limit: 4
    t.integer  "position",                limit: 4
    t.string   "attachment_content_type", limit: 255
    t.string   "attachment_file_name",    limit: 255
    t.string   "type",                    limit: 75
    t.datetime "attachment_updated_at"
    t.text     "alt",                     limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "spree_assets", ["viewable_id"], name: "index_assets_on_viewable_id", using: :btree
  add_index "spree_assets", ["viewable_type", "type"], name: "index_assets_on_viewable_type_and_type", using: :btree

  create_table "spree_calculators", force: :cascade do |t|
    t.string   "type",            limit: 255
    t.integer  "calculable_id",   limit: 4
    t.string   "calculable_type", limit: 255
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.text     "preferences",     limit: 65535
    t.datetime "deleted_at"
  end

  add_index "spree_calculators", ["calculable_id", "calculable_type"], name: "index_spree_calculators_on_calculable_id_and_calculable_type", using: :btree
  add_index "spree_calculators", ["deleted_at"], name: "index_spree_calculators_on_deleted_at", using: :btree
  add_index "spree_calculators", ["id", "type"], name: "index_spree_calculators_on_id_and_type", using: :btree

  create_table "spree_countries", force: :cascade do |t|
    t.string   "iso_name",        limit: 255
    t.string   "iso",             limit: 255
    t.string   "iso3",            limit: 255
    t.string   "name",            limit: 255
    t.integer  "numcode",         limit: 4
    t.boolean  "states_required",             default: false
    t.datetime "updated_at"
  end

  create_table "spree_credit_cards", force: :cascade do |t|
    t.string   "month",                       limit: 255
    t.string   "year",                        limit: 255
    t.string   "cc_type",                     limit: 255
    t.string   "last_digits",                 limit: 255
    t.integer  "address_id",                  limit: 4
    t.string   "gateway_customer_profile_id", limit: 255
    t.string   "gateway_payment_profile_id",  limit: 255
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
    t.string   "name",                        limit: 255
    t.integer  "user_id",                     limit: 4
    t.integer  "payment_method_id",           limit: 4
    t.boolean  "default",                                 default: false, null: false
  end

  add_index "spree_credit_cards", ["address_id"], name: "index_spree_credit_cards_on_address_id", using: :btree
  add_index "spree_credit_cards", ["payment_method_id"], name: "index_spree_credit_cards_on_payment_method_id", using: :btree
  add_index "spree_credit_cards", ["user_id"], name: "index_spree_credit_cards_on_user_id", using: :btree

  create_table "spree_customer_returns", force: :cascade do |t|
    t.string   "number",            limit: 255
    t.integer  "stock_location_id", limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "spree_gateways", force: :cascade do |t|
    t.string   "type",        limit: 255
    t.string   "name",        limit: 255
    t.text     "description", limit: 65535
    t.boolean  "active",                    default: true
    t.string   "environment", limit: 255,   default: "development"
    t.string   "server",      limit: 255,   default: "test"
    t.boolean  "test_mode",                 default: true
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.text     "preferences", limit: 65535
  end

  add_index "spree_gateways", ["active"], name: "index_spree_gateways_on_active", using: :btree
  add_index "spree_gateways", ["test_mode"], name: "index_spree_gateways_on_test_mode", using: :btree

  create_table "spree_inventory_units", force: :cascade do |t|
    t.string   "state",        limit: 255
    t.integer  "variant_id",   limit: 4
    t.integer  "order_id",     limit: 4
    t.integer  "shipment_id",  limit: 4
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.boolean  "pending",                  default: true
    t.integer  "line_item_id", limit: 4
  end

  add_index "spree_inventory_units", ["line_item_id"], name: "index_spree_inventory_units_on_line_item_id", using: :btree
  add_index "spree_inventory_units", ["order_id"], name: "index_inventory_units_on_order_id", using: :btree
  add_index "spree_inventory_units", ["shipment_id"], name: "index_inventory_units_on_shipment_id", using: :btree
  add_index "spree_inventory_units", ["variant_id"], name: "index_inventory_units_on_variant_id", using: :btree

  create_table "spree_line_items", force: :cascade do |t|
    t.integer  "variant_id",                   limit: 4
    t.integer  "order_id",                     limit: 4
    t.integer  "quantity",                     limit: 4,                                          null: false
    t.decimal  "price",                                    precision: 10, scale: 2,               null: false
    t.datetime "created_at",                                                                      null: false
    t.datetime "updated_at",                                                                      null: false
    t.string   "currency",                     limit: 255
    t.decimal  "cost_price",                               precision: 10, scale: 2
    t.integer  "tax_category_id",              limit: 4
    t.decimal  "adjustment_total",                         precision: 10, scale: 2, default: 0.0
    t.decimal  "additional_tax_total",                     precision: 10, scale: 2, default: 0.0
    t.decimal  "promo_total",                              precision: 10, scale: 2, default: 0.0
    t.decimal  "included_tax_total",                       precision: 10, scale: 2, default: 0.0, null: false
    t.decimal  "pre_tax_amount",                           precision: 12, scale: 4, default: 0.0, null: false
    t.decimal  "taxable_adjustment_total",                 precision: 10, scale: 2, default: 0.0, null: false
    t.decimal  "non_taxable_adjustment_total",             precision: 10, scale: 2, default: 0.0, null: false
  end

  add_index "spree_line_items", ["order_id"], name: "index_spree_line_items_on_order_id", using: :btree
  add_index "spree_line_items", ["tax_category_id"], name: "index_spree_line_items_on_tax_category_id", using: :btree
  add_index "spree_line_items", ["variant_id"], name: "index_spree_line_items_on_variant_id", using: :btree

  create_table "spree_log_entries", force: :cascade do |t|
    t.integer  "source_id",   limit: 4
    t.string   "source_type", limit: 255
    t.text     "details",     limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "spree_log_entries", ["source_id", "source_type"], name: "index_spree_log_entries_on_source_id_and_source_type", using: :btree

  create_table "spree_option_type_prototypes", id: false, force: :cascade do |t|
    t.integer "prototype_id",   limit: 4
    t.integer "option_type_id", limit: 4
  end

  add_index "spree_option_type_prototypes", ["option_type_id"], name: "index_spree_option_type_prototypes_on_option_type_id", using: :btree
  add_index "spree_option_type_prototypes", ["prototype_id", "option_type_id"], name: "index_option_types_prototypes_on_prototype_and_option_type", using: :btree

  create_table "spree_option_types", force: :cascade do |t|
    t.string   "name",         limit: 100
    t.string   "presentation", limit: 100
    t.integer  "position",     limit: 4,   default: 0, null: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "spree_option_types", ["position"], name: "index_spree_option_types_on_position", using: :btree

  create_table "spree_option_value_variants", id: false, force: :cascade do |t|
    t.integer "variant_id",      limit: 4
    t.integer "option_value_id", limit: 4
  end

  add_index "spree_option_value_variants", ["option_value_id"], name: "index_spree_option_value_variants_on_option_value_id", using: :btree
  add_index "spree_option_value_variants", ["variant_id", "option_value_id"], name: "index_option_values_variants_on_variant_id_and_option_value_id", using: :btree

  create_table "spree_option_values", force: :cascade do |t|
    t.integer  "position",       limit: 4
    t.string   "name",           limit: 255
    t.string   "presentation",   limit: 255
    t.integer  "option_type_id", limit: 4
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "spree_option_values", ["option_type_id"], name: "index_spree_option_values_on_option_type_id", using: :btree
  add_index "spree_option_values", ["position"], name: "index_spree_option_values_on_position", using: :btree

  create_table "spree_order_promotions", id: false, force: :cascade do |t|
    t.integer "order_id",     limit: 4
    t.integer "promotion_id", limit: 4
  end

  add_index "spree_order_promotions", ["order_id"], name: "index_spree_order_promotions_on_order_id", using: :btree
  add_index "spree_order_promotions", ["promotion_id", "order_id"], name: "index_spree_order_promotions_on_promotion_id_and_order_id", using: :btree

  create_table "spree_orders", force: :cascade do |t|
    t.string   "number",                       limit: 32
    t.decimal  "item_total",                                 precision: 10, scale: 2, default: 0.0,     null: false
    t.decimal  "total",                                      precision: 10, scale: 2, default: 0.0,     null: false
    t.string   "state",                        limit: 255
    t.decimal  "adjustment_total",                           precision: 10, scale: 2, default: 0.0,     null: false
    t.integer  "user_id",                      limit: 4
    t.datetime "completed_at"
    t.integer  "bill_address_id",              limit: 4
    t.integer  "ship_address_id",              limit: 4
    t.decimal  "payment_total",                              precision: 10, scale: 2, default: 0.0
    t.integer  "shipping_method_id",           limit: 4
    t.string   "shipment_state",               limit: 255
    t.string   "payment_state",                limit: 255
    t.string   "email",                        limit: 255
    t.text     "special_instructions",         limit: 65535
    t.datetime "created_at",                                                                            null: false
    t.datetime "updated_at",                                                                            null: false
    t.string   "currency",                     limit: 255
    t.string   "last_ip_address",              limit: 255
    t.integer  "created_by_id",                limit: 4
    t.decimal  "shipment_total",                             precision: 10, scale: 2, default: 0.0,     null: false
    t.decimal  "additional_tax_total",                       precision: 10, scale: 2, default: 0.0
    t.decimal  "promo_total",                                precision: 10, scale: 2, default: 0.0
    t.string   "channel",                      limit: 255,                            default: "spree"
    t.decimal  "included_tax_total",                         precision: 10, scale: 2, default: 0.0,     null: false
    t.integer  "item_count",                   limit: 4,                              default: 0
    t.integer  "approver_id",                  limit: 4
    t.datetime "approved_at"
    t.boolean  "confirmation_delivered",                                              default: false
    t.boolean  "considered_risky",                                                    default: false
    t.string   "guest_token",                  limit: 255
    t.datetime "canceled_at"
    t.integer  "canceler_id",                  limit: 4
    t.integer  "store_id",                     limit: 4
    t.integer  "state_lock_version",           limit: 4,                              default: 0,       null: false
    t.decimal  "taxable_adjustment_total",                   precision: 10, scale: 2, default: 0.0,     null: false
    t.decimal  "non_taxable_adjustment_total",               precision: 10, scale: 2, default: 0.0,     null: false
  end

  add_index "spree_orders", ["approver_id"], name: "index_spree_orders_on_approver_id", using: :btree
  add_index "spree_orders", ["bill_address_id"], name: "index_spree_orders_on_bill_address_id", using: :btree
  add_index "spree_orders", ["canceler_id"], name: "index_spree_orders_on_canceler_id", using: :btree
  add_index "spree_orders", ["completed_at"], name: "index_spree_orders_on_completed_at", using: :btree
  add_index "spree_orders", ["confirmation_delivered"], name: "index_spree_orders_on_confirmation_delivered", using: :btree
  add_index "spree_orders", ["considered_risky"], name: "index_spree_orders_on_considered_risky", using: :btree
  add_index "spree_orders", ["created_by_id"], name: "index_spree_orders_on_created_by_id", using: :btree
  add_index "spree_orders", ["guest_token"], name: "index_spree_orders_on_guest_token", using: :btree
  add_index "spree_orders", ["number"], name: "index_spree_orders_on_number", using: :btree
  add_index "spree_orders", ["ship_address_id"], name: "index_spree_orders_on_ship_address_id", using: :btree
  add_index "spree_orders", ["shipping_method_id"], name: "index_spree_orders_on_shipping_method_id", using: :btree
  add_index "spree_orders", ["store_id"], name: "index_spree_orders_on_store_id", using: :btree
  add_index "spree_orders", ["user_id", "created_by_id"], name: "index_spree_orders_on_user_id_and_created_by_id", using: :btree

  create_table "spree_payment_capture_events", force: :cascade do |t|
    t.decimal  "amount",               precision: 10, scale: 2, default: 0.0
    t.integer  "payment_id", limit: 4
    t.datetime "created_at",                                                  null: false
    t.datetime "updated_at",                                                  null: false
  end

  add_index "spree_payment_capture_events", ["payment_id"], name: "index_spree_payment_capture_events_on_payment_id", using: :btree

  create_table "spree_payment_methods", force: :cascade do |t|
    t.string   "type",         limit: 255
    t.string   "name",         limit: 255
    t.text     "description",  limit: 65535
    t.boolean  "active",                     default: true
    t.datetime "deleted_at"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.string   "display_on",   limit: 255,   default: "both"
    t.boolean  "auto_capture"
    t.text     "preferences",  limit: 65535
    t.integer  "position",     limit: 4,     default: 0
  end

  add_index "spree_payment_methods", ["id", "type"], name: "index_spree_payment_methods_on_id_and_type", using: :btree

  create_table "spree_payments", force: :cascade do |t|
    t.decimal  "amount",                           precision: 10, scale: 2, default: 0.0, null: false
    t.integer  "order_id",             limit: 4
    t.integer  "source_id",            limit: 4
    t.string   "source_type",          limit: 255
    t.integer  "payment_method_id",    limit: 4
    t.string   "state",                limit: 255
    t.string   "response_code",        limit: 255
    t.string   "avs_response",         limit: 255
    t.datetime "created_at",                                                              null: false
    t.datetime "updated_at",                                                              null: false
    t.string   "number",               limit: 255
    t.string   "cvv_response_code",    limit: 255
    t.string   "cvv_response_message", limit: 255
  end

  add_index "spree_payments", ["number"], name: "index_spree_payments_on_number", using: :btree
  add_index "spree_payments", ["order_id"], name: "index_spree_payments_on_order_id", using: :btree
  add_index "spree_payments", ["payment_method_id"], name: "index_spree_payments_on_payment_method_id", using: :btree
  add_index "spree_payments", ["source_id", "source_type"], name: "index_spree_payments_on_source_id_and_source_type", using: :btree

  create_table "spree_preferences", force: :cascade do |t|
    t.text     "value",      limit: 65535
    t.string   "key",        limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "spree_preferences", ["key"], name: "index_spree_preferences_on_key", unique: true, using: :btree

  create_table "spree_prices", force: :cascade do |t|
    t.integer  "variant_id", limit: 4,                            null: false
    t.decimal  "amount",                 precision: 10, scale: 2
    t.string   "currency",   limit: 255
    t.datetime "deleted_at"
  end

  add_index "spree_prices", ["deleted_at"], name: "index_spree_prices_on_deleted_at", using: :btree
  add_index "spree_prices", ["variant_id", "currency"], name: "index_spree_prices_on_variant_id_and_currency", using: :btree

  create_table "spree_product_option_types", force: :cascade do |t|
    t.integer  "position",       limit: 4
    t.integer  "product_id",     limit: 4
    t.integer  "option_type_id", limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "spree_product_option_types", ["option_type_id"], name: "index_spree_product_option_types_on_option_type_id", using: :btree
  add_index "spree_product_option_types", ["position"], name: "index_spree_product_option_types_on_position", using: :btree
  add_index "spree_product_option_types", ["product_id"], name: "index_spree_product_option_types_on_product_id", using: :btree

  create_table "spree_product_promotion_rules", id: false, force: :cascade do |t|
    t.integer "product_id",        limit: 4
    t.integer "promotion_rule_id", limit: 4
  end

  add_index "spree_product_promotion_rules", ["product_id"], name: "index_products_promotion_rules_on_product_id", using: :btree
  add_index "spree_product_promotion_rules", ["promotion_rule_id", "product_id"], name: "index_products_promotion_rules_on_promotion_rule_and_product", using: :btree

  create_table "spree_product_properties", force: :cascade do |t|
    t.string   "value",       limit: 255
    t.integer  "product_id",  limit: 4
    t.integer  "property_id", limit: 4
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "position",    limit: 4,   default: 0
  end

  add_index "spree_product_properties", ["position"], name: "index_spree_product_properties_on_position", using: :btree
  add_index "spree_product_properties", ["product_id"], name: "index_product_properties_on_product_id", using: :btree
  add_index "spree_product_properties", ["property_id"], name: "index_spree_product_properties_on_property_id", using: :btree

  create_table "spree_products", force: :cascade do |t|
    t.string   "name",                 limit: 255,   default: "",   null: false
    t.text     "description",          limit: 65535
    t.datetime "available_on"
    t.datetime "discontinue_on"
    t.datetime "deleted_at"
    t.string   "slug",                 limit: 255
    t.text     "meta_description",     limit: 65535
    t.string   "meta_keywords",        limit: 255
    t.integer  "tax_category_id",      limit: 4
    t.integer  "shipping_category_id", limit: 4
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.boolean  "promotionable",                      default: true
    t.string   "meta_title",           limit: 255
  end

  add_index "spree_products", ["available_on"], name: "index_spree_products_on_available_on", using: :btree
  add_index "spree_products", ["deleted_at"], name: "index_spree_products_on_deleted_at", using: :btree
  add_index "spree_products", ["discontinue_on"], name: "index_spree_products_on_discontinue_on", using: :btree
  add_index "spree_products", ["name"], name: "index_spree_products_on_name", using: :btree
  add_index "spree_products", ["shipping_category_id"], name: "index_spree_products_on_shipping_category_id", using: :btree
  add_index "spree_products", ["slug"], name: "index_spree_products_on_slug", unique: true, using: :btree
  add_index "spree_products", ["tax_category_id"], name: "index_spree_products_on_tax_category_id", using: :btree

  create_table "spree_products_taxons", force: :cascade do |t|
    t.integer "product_id", limit: 4
    t.integer "taxon_id",   limit: 4
    t.integer "position",   limit: 4
  end

  add_index "spree_products_taxons", ["position"], name: "index_spree_products_taxons_on_position", using: :btree
  add_index "spree_products_taxons", ["product_id"], name: "index_spree_products_taxons_on_product_id", using: :btree
  add_index "spree_products_taxons", ["taxon_id"], name: "index_spree_products_taxons_on_taxon_id", using: :btree

  create_table "spree_promotion_action_line_items", force: :cascade do |t|
    t.integer "promotion_action_id", limit: 4
    t.integer "variant_id",          limit: 4
    t.integer "quantity",            limit: 4, default: 1
  end

  add_index "spree_promotion_action_line_items", ["promotion_action_id"], name: "index_spree_promotion_action_line_items_on_promotion_action_id", using: :btree
  add_index "spree_promotion_action_line_items", ["variant_id"], name: "index_spree_promotion_action_line_items_on_variant_id", using: :btree

  create_table "spree_promotion_actions", force: :cascade do |t|
    t.integer  "promotion_id", limit: 4
    t.integer  "position",     limit: 4
    t.string   "type",         limit: 255
    t.datetime "deleted_at"
  end

  add_index "spree_promotion_actions", ["deleted_at"], name: "index_spree_promotion_actions_on_deleted_at", using: :btree
  add_index "spree_promotion_actions", ["id", "type"], name: "index_spree_promotion_actions_on_id_and_type", using: :btree
  add_index "spree_promotion_actions", ["promotion_id"], name: "index_spree_promotion_actions_on_promotion_id", using: :btree

  create_table "spree_promotion_categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "code",       limit: 255
  end

  create_table "spree_promotion_rule_taxons", force: :cascade do |t|
    t.integer "taxon_id",          limit: 4
    t.integer "promotion_rule_id", limit: 4
  end

  add_index "spree_promotion_rule_taxons", ["promotion_rule_id"], name: "index_spree_promotion_rule_taxons_on_promotion_rule_id", using: :btree
  add_index "spree_promotion_rule_taxons", ["taxon_id"], name: "index_spree_promotion_rule_taxons_on_taxon_id", using: :btree

  create_table "spree_promotion_rule_users", id: false, force: :cascade do |t|
    t.integer "user_id",           limit: 4
    t.integer "promotion_rule_id", limit: 4
  end

  add_index "spree_promotion_rule_users", ["promotion_rule_id"], name: "index_promotion_rules_users_on_promotion_rule_id", using: :btree
  add_index "spree_promotion_rule_users", ["user_id", "promotion_rule_id"], name: "index_promotion_rules_users_on_user_id_and_promotion_rule_id", using: :btree

  create_table "spree_promotion_rules", force: :cascade do |t|
    t.integer  "promotion_id",     limit: 4
    t.integer  "user_id",          limit: 4
    t.integer  "product_group_id", limit: 4
    t.string   "type",             limit: 255
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "code",             limit: 255
    t.text     "preferences",      limit: 65535
  end

  add_index "spree_promotion_rules", ["product_group_id"], name: "index_promotion_rules_on_product_group_id", using: :btree
  add_index "spree_promotion_rules", ["promotion_id"], name: "index_spree_promotion_rules_on_promotion_id", using: :btree
  add_index "spree_promotion_rules", ["user_id"], name: "index_promotion_rules_on_user_id", using: :btree

  create_table "spree_promotions", force: :cascade do |t|
    t.string   "description",           limit: 255
    t.datetime "expires_at"
    t.datetime "starts_at"
    t.string   "name",                  limit: 255
    t.string   "type",                  limit: 255
    t.integer  "usage_limit",           limit: 4
    t.string   "match_policy",          limit: 255, default: "all"
    t.string   "code",                  limit: 255
    t.boolean  "advertise",                         default: false
    t.string   "path",                  limit: 255
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.integer  "promotion_category_id", limit: 4
  end

  add_index "spree_promotions", ["advertise"], name: "index_spree_promotions_on_advertise", using: :btree
  add_index "spree_promotions", ["code"], name: "index_spree_promotions_on_code", using: :btree
  add_index "spree_promotions", ["expires_at"], name: "index_spree_promotions_on_expires_at", using: :btree
  add_index "spree_promotions", ["id", "type"], name: "index_spree_promotions_on_id_and_type", using: :btree
  add_index "spree_promotions", ["promotion_category_id"], name: "index_spree_promotions_on_promotion_category_id", using: :btree
  add_index "spree_promotions", ["starts_at"], name: "index_spree_promotions_on_starts_at", using: :btree

  create_table "spree_properties", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.string   "presentation", limit: 255, null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "spree_property_prototypes", id: false, force: :cascade do |t|
    t.integer "prototype_id", limit: 4
    t.integer "property_id",  limit: 4
  end

  add_index "spree_property_prototypes", ["prototype_id", "property_id"], name: "index_properties_prototypes_on_prototype_and_property", using: :btree

  create_table "spree_prototype_taxons", force: :cascade do |t|
    t.integer "taxon_id",     limit: 4
    t.integer "prototype_id", limit: 4
  end

  add_index "spree_prototype_taxons", ["prototype_id", "taxon_id"], name: "index_spree_prototype_taxons_on_prototype_id_and_taxon_id", using: :btree
  add_index "spree_prototype_taxons", ["taxon_id"], name: "index_spree_prototype_taxons_on_taxon_id", using: :btree

  create_table "spree_prototypes", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "spree_refund_reasons", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.boolean  "active",                 default: true
    t.boolean  "mutable",                default: true
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  create_table "spree_refunds", force: :cascade do |t|
    t.integer  "payment_id",       limit: 4
    t.decimal  "amount",                       precision: 10, scale: 2, default: 0.0, null: false
    t.string   "transaction_id",   limit: 255
    t.datetime "created_at",                                                          null: false
    t.datetime "updated_at",                                                          null: false
    t.integer  "refund_reason_id", limit: 4
    t.integer  "reimbursement_id", limit: 4
  end

  add_index "spree_refunds", ["refund_reason_id"], name: "index_refunds_on_refund_reason_id", using: :btree

  create_table "spree_reimbursement_credits", force: :cascade do |t|
    t.decimal "amount",                       precision: 10, scale: 2, default: 0.0, null: false
    t.integer "reimbursement_id", limit: 4
    t.integer "creditable_id",    limit: 4
    t.string  "creditable_type",  limit: 255
  end

  create_table "spree_reimbursement_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.boolean  "active",                 default: true
    t.boolean  "mutable",                default: true
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "type",       limit: 255
  end

  add_index "spree_reimbursement_types", ["type"], name: "index_spree_reimbursement_types_on_type", using: :btree

  create_table "spree_reimbursements", force: :cascade do |t|
    t.string   "number",               limit: 255
    t.string   "reimbursement_status", limit: 255
    t.integer  "customer_return_id",   limit: 4
    t.integer  "order_id",             limit: 4
    t.decimal  "total",                            precision: 10, scale: 2
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
  end

  add_index "spree_reimbursements", ["customer_return_id"], name: "index_spree_reimbursements_on_customer_return_id", using: :btree
  add_index "spree_reimbursements", ["order_id"], name: "index_spree_reimbursements_on_order_id", using: :btree

  create_table "spree_return_authorization_reasons", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.boolean  "active",                 default: true
    t.boolean  "mutable",                default: true
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  create_table "spree_return_authorizations", force: :cascade do |t|
    t.string   "number",                         limit: 255
    t.string   "state",                          limit: 255
    t.integer  "order_id",                       limit: 4
    t.text     "memo",                           limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "stock_location_id",              limit: 4
    t.integer  "return_authorization_reason_id", limit: 4
  end

  add_index "spree_return_authorizations", ["return_authorization_reason_id"], name: "index_return_authorizations_on_return_authorization_reason_id", using: :btree

  create_table "spree_return_items", force: :cascade do |t|
    t.integer  "return_authorization_id",         limit: 4
    t.integer  "inventory_unit_id",               limit: 4
    t.integer  "exchange_variant_id",             limit: 4
    t.datetime "created_at",                                                                            null: false
    t.datetime "updated_at",                                                                            null: false
    t.decimal  "pre_tax_amount",                                precision: 12, scale: 4, default: 0.0,  null: false
    t.decimal  "included_tax_total",                            precision: 12, scale: 4, default: 0.0,  null: false
    t.decimal  "additional_tax_total",                          precision: 12, scale: 4, default: 0.0,  null: false
    t.string   "reception_status",                limit: 255
    t.string   "acceptance_status",               limit: 255
    t.integer  "customer_return_id",              limit: 4
    t.integer  "reimbursement_id",                limit: 4
    t.integer  "exchange_inventory_unit_id",      limit: 4
    t.text     "acceptance_status_errors",        limit: 65535
    t.integer  "preferred_reimbursement_type_id", limit: 4
    t.integer  "override_reimbursement_type_id",  limit: 4
    t.boolean  "resellable",                                                             default: true, null: false
  end

  add_index "spree_return_items", ["customer_return_id"], name: "index_return_items_on_customer_return_id", using: :btree
  add_index "spree_return_items", ["exchange_inventory_unit_id"], name: "index_spree_return_items_on_exchange_inventory_unit_id", using: :btree

  create_table "spree_role_users", id: false, force: :cascade do |t|
    t.integer "role_id", limit: 4
    t.integer "user_id", limit: 4
  end

  add_index "spree_role_users", ["role_id"], name: "index_spree_role_users_on_role_id", using: :btree
  add_index "spree_role_users", ["user_id"], name: "index_spree_role_users_on_user_id", using: :btree

  create_table "spree_roles", force: :cascade do |t|
    t.string "name", limit: 255
  end

  create_table "spree_shipments", force: :cascade do |t|
    t.string   "tracking",                     limit: 255
    t.string   "number",                       limit: 255
    t.decimal  "cost",                                     precision: 10, scale: 2, default: 0.0
    t.datetime "shipped_at"
    t.integer  "order_id",                     limit: 4
    t.integer  "address_id",                   limit: 4
    t.string   "state",                        limit: 255
    t.datetime "created_at",                                                                      null: false
    t.datetime "updated_at",                                                                      null: false
    t.integer  "stock_location_id",            limit: 4
    t.decimal  "adjustment_total",                         precision: 10, scale: 2, default: 0.0
    t.decimal  "additional_tax_total",                     precision: 10, scale: 2, default: 0.0
    t.decimal  "promo_total",                              precision: 10, scale: 2, default: 0.0
    t.decimal  "included_tax_total",                       precision: 10, scale: 2, default: 0.0, null: false
    t.decimal  "pre_tax_amount",                           precision: 12, scale: 4, default: 0.0, null: false
    t.decimal  "taxable_adjustment_total",                 precision: 10, scale: 2, default: 0.0, null: false
    t.decimal  "non_taxable_adjustment_total",             precision: 10, scale: 2, default: 0.0, null: false
  end

  add_index "spree_shipments", ["address_id"], name: "index_spree_shipments_on_address_id", using: :btree
  add_index "spree_shipments", ["number"], name: "index_shipments_on_number", using: :btree
  add_index "spree_shipments", ["order_id"], name: "index_spree_shipments_on_order_id", using: :btree
  add_index "spree_shipments", ["stock_location_id"], name: "index_spree_shipments_on_stock_location_id", using: :btree

  create_table "spree_shipping_categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "spree_shipping_method_categories", force: :cascade do |t|
    t.integer  "shipping_method_id",   limit: 4, null: false
    t.integer  "shipping_category_id", limit: 4, null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "spree_shipping_method_categories", ["shipping_category_id", "shipping_method_id"], name: "unique_spree_shipping_method_categories", unique: true, using: :btree
  add_index "spree_shipping_method_categories", ["shipping_method_id"], name: "index_spree_shipping_method_categories_on_shipping_method_id", using: :btree

  create_table "spree_shipping_method_zones", id: false, force: :cascade do |t|
    t.integer "shipping_method_id", limit: 4
    t.integer "zone_id",            limit: 4
  end

  create_table "spree_shipping_methods", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "display_on",      limit: 255
    t.datetime "deleted_at"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "tracking_url",    limit: 255
    t.string   "admin_name",      limit: 255
    t.integer  "tax_category_id", limit: 4
    t.string   "code",            limit: 255
  end

  add_index "spree_shipping_methods", ["deleted_at"], name: "index_spree_shipping_methods_on_deleted_at", using: :btree
  add_index "spree_shipping_methods", ["tax_category_id"], name: "index_spree_shipping_methods_on_tax_category_id", using: :btree

  create_table "spree_shipping_rates", force: :cascade do |t|
    t.integer  "shipment_id",        limit: 4
    t.integer  "shipping_method_id", limit: 4
    t.boolean  "selected",                                             default: false
    t.decimal  "cost",                         precision: 8, scale: 2, default: 0.0
    t.datetime "created_at",                                                           null: false
    t.datetime "updated_at",                                                           null: false
    t.integer  "tax_rate_id",        limit: 4
  end

  add_index "spree_shipping_rates", ["selected"], name: "index_spree_shipping_rates_on_selected", using: :btree
  add_index "spree_shipping_rates", ["shipment_id", "shipping_method_id"], name: "spree_shipping_rates_join_index", unique: true, using: :btree
  add_index "spree_shipping_rates", ["tax_rate_id"], name: "index_spree_shipping_rates_on_tax_rate_id", using: :btree

  create_table "spree_state_changes", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.string   "previous_state", limit: 255
    t.integer  "stateful_id",    limit: 4
    t.integer  "user_id",        limit: 4
    t.string   "stateful_type",  limit: 255
    t.string   "next_state",     limit: 255
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "spree_state_changes", ["stateful_id", "stateful_type"], name: "index_spree_state_changes_on_stateful_id_and_stateful_type", using: :btree

  create_table "spree_states", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "abbr",       limit: 255
    t.integer  "country_id", limit: 4
    t.datetime "updated_at"
  end

  add_index "spree_states", ["country_id"], name: "index_spree_states_on_country_id", using: :btree

  create_table "spree_stock_items", force: :cascade do |t|
    t.integer  "stock_location_id", limit: 4
    t.integer  "variant_id",        limit: 4
    t.integer  "count_on_hand",     limit: 4, default: 0,     null: false
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.boolean  "backorderable",               default: false
    t.datetime "deleted_at"
  end

  add_index "spree_stock_items", ["backorderable"], name: "index_spree_stock_items_on_backorderable", using: :btree
  add_index "spree_stock_items", ["deleted_at"], name: "index_spree_stock_items_on_deleted_at", using: :btree
  add_index "spree_stock_items", ["stock_location_id", "variant_id"], name: "stock_item_by_loc_and_var_id", using: :btree
  add_index "spree_stock_items", ["variant_id"], name: "index_spree_stock_items_on_variant_id", using: :btree

  create_table "spree_stock_locations", force: :cascade do |t|
    t.string   "name",                   limit: 255
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.boolean  "default",                            default: false, null: false
    t.string   "address1",               limit: 255
    t.string   "address2",               limit: 255
    t.string   "city",                   limit: 255
    t.integer  "state_id",               limit: 4
    t.string   "state_name",             limit: 255
    t.integer  "country_id",             limit: 4
    t.string   "zipcode",                limit: 255
    t.string   "phone",                  limit: 255
    t.boolean  "active",                             default: true
    t.boolean  "backorderable_default",              default: false
    t.boolean  "propagate_all_variants",             default: true
    t.string   "admin_name",             limit: 255
  end

  add_index "spree_stock_locations", ["active"], name: "index_spree_stock_locations_on_active", using: :btree
  add_index "spree_stock_locations", ["backorderable_default"], name: "index_spree_stock_locations_on_backorderable_default", using: :btree
  add_index "spree_stock_locations", ["country_id"], name: "index_spree_stock_locations_on_country_id", using: :btree
  add_index "spree_stock_locations", ["propagate_all_variants"], name: "index_spree_stock_locations_on_propagate_all_variants", using: :btree
  add_index "spree_stock_locations", ["state_id"], name: "index_spree_stock_locations_on_state_id", using: :btree

  create_table "spree_stock_movements", force: :cascade do |t|
    t.integer  "stock_item_id",   limit: 4
    t.integer  "quantity",        limit: 4,   default: 0
    t.string   "action",          limit: 255
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.integer  "originator_id",   limit: 4
    t.string   "originator_type", limit: 255
  end

  add_index "spree_stock_movements", ["stock_item_id"], name: "index_spree_stock_movements_on_stock_item_id", using: :btree

  create_table "spree_stock_transfers", force: :cascade do |t|
    t.string   "type",                    limit: 255
    t.string   "reference",               limit: 255
    t.integer  "source_location_id",      limit: 4
    t.integer  "destination_location_id", limit: 4
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "number",                  limit: 255
  end

  add_index "spree_stock_transfers", ["destination_location_id"], name: "index_spree_stock_transfers_on_destination_location_id", using: :btree
  add_index "spree_stock_transfers", ["number"], name: "index_spree_stock_transfers_on_number", using: :btree
  add_index "spree_stock_transfers", ["source_location_id"], name: "index_spree_stock_transfers_on_source_location_id", using: :btree

  create_table "spree_stores", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.string   "url",               limit: 255
    t.text     "meta_description",  limit: 65535
    t.text     "meta_keywords",     limit: 65535
    t.string   "seo_title",         limit: 255
    t.string   "mail_from_address", limit: 255
    t.string   "default_currency",  limit: 255
    t.string   "code",              limit: 255
    t.boolean  "default",                         default: false, null: false
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "spree_stores", ["code"], name: "index_spree_stores_on_code", using: :btree
  add_index "spree_stores", ["default"], name: "index_spree_stores_on_default", using: :btree
  add_index "spree_stores", ["url"], name: "index_spree_stores_on_url", using: :btree

  create_table "spree_tax_categories", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.boolean  "is_default",              default: false
    t.datetime "deleted_at"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.string   "tax_code",    limit: 255
  end

  add_index "spree_tax_categories", ["deleted_at"], name: "index_spree_tax_categories_on_deleted_at", using: :btree
  add_index "spree_tax_categories", ["is_default"], name: "index_spree_tax_categories_on_is_default", using: :btree

  create_table "spree_tax_rates", force: :cascade do |t|
    t.decimal  "amount",                         precision: 8, scale: 5
    t.integer  "zone_id",            limit: 4
    t.integer  "tax_category_id",    limit: 4
    t.boolean  "included_in_price",                                      default: false
    t.datetime "created_at",                                                             null: false
    t.datetime "updated_at",                                                             null: false
    t.string   "name",               limit: 255
    t.boolean  "show_rate_in_label",                                     default: true
    t.datetime "deleted_at"
  end

  add_index "spree_tax_rates", ["deleted_at"], name: "index_spree_tax_rates_on_deleted_at", using: :btree
  add_index "spree_tax_rates", ["included_in_price"], name: "index_spree_tax_rates_on_included_in_price", using: :btree
  add_index "spree_tax_rates", ["show_rate_in_label"], name: "index_spree_tax_rates_on_show_rate_in_label", using: :btree
  add_index "spree_tax_rates", ["tax_category_id"], name: "index_spree_tax_rates_on_tax_category_id", using: :btree
  add_index "spree_tax_rates", ["zone_id"], name: "index_spree_tax_rates_on_zone_id", using: :btree

  create_table "spree_taxonomies", force: :cascade do |t|
    t.string   "name",       limit: 255,             null: false
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "position",   limit: 4,   default: 0
  end

  add_index "spree_taxonomies", ["position"], name: "index_spree_taxonomies_on_position", using: :btree

  create_table "spree_taxons", force: :cascade do |t|
    t.integer  "parent_id",         limit: 4
    t.integer  "position",          limit: 4,     default: 0
    t.string   "name",              limit: 255,               null: false
    t.string   "permalink",         limit: 255
    t.integer  "taxonomy_id",       limit: 4
    t.integer  "lft",               limit: 4
    t.integer  "rgt",               limit: 4
    t.string   "icon_file_name",    limit: 255
    t.string   "icon_content_type", limit: 255
    t.integer  "icon_file_size",    limit: 4
    t.datetime "icon_updated_at"
    t.text     "description",       limit: 65535
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.string   "meta_title",        limit: 255
    t.string   "meta_description",  limit: 255
    t.string   "meta_keywords",     limit: 255
    t.integer  "depth",             limit: 4
  end

  add_index "spree_taxons", ["parent_id"], name: "index_taxons_on_parent_id", using: :btree
  add_index "spree_taxons", ["permalink"], name: "index_taxons_on_permalink", using: :btree
  add_index "spree_taxons", ["position"], name: "index_spree_taxons_on_position", using: :btree
  add_index "spree_taxons", ["taxonomy_id"], name: "index_taxons_on_taxonomy_id", using: :btree

  create_table "spree_trackers", force: :cascade do |t|
    t.string   "analytics_id", limit: 255
    t.boolean  "active",                   default: true
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  add_index "spree_trackers", ["active"], name: "index_spree_trackers_on_active", using: :btree

  create_table "spree_users", force: :cascade do |t|
    t.string   "encrypted_password",     limit: 128
    t.string   "password_salt",          limit: 128
    t.string   "email",                  limit: 255
    t.string   "remember_token",         limit: 255
    t.string   "persistence_token",      limit: 255
    t.string   "reset_password_token",   limit: 255
    t.string   "perishable_token",       limit: 255
    t.integer  "sign_in_count",          limit: 4,   default: 0, null: false
    t.integer  "failed_attempts",        limit: 4,   default: 0, null: false
    t.datetime "last_request_at"
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "login",                  limit: 255
    t.integer  "ship_address_id",        limit: 4
    t.integer  "bill_address_id",        limit: 4
    t.string   "authentication_token",   limit: 255
    t.string   "unlock_token",           limit: 255
    t.datetime "locked_at"
    t.datetime "reset_password_sent_at"
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.string   "spree_api_key",          limit: 48
    t.datetime "remember_created_at"
    t.datetime "deleted_at"
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
  end

  add_index "spree_users", ["bill_address_id"], name: "index_spree_users_on_bill_address_id", using: :btree
  add_index "spree_users", ["deleted_at"], name: "index_spree_users_on_deleted_at", using: :btree
  add_index "spree_users", ["email"], name: "email_idx_unique", unique: true, using: :btree
  add_index "spree_users", ["ship_address_id"], name: "index_spree_users_on_ship_address_id", using: :btree
  add_index "spree_users", ["spree_api_key"], name: "index_spree_users_on_spree_api_key", using: :btree

  create_table "spree_variants", force: :cascade do |t|
    t.string   "sku",               limit: 255,                          default: "",    null: false
    t.decimal  "weight",                        precision: 8,  scale: 2, default: 0.0
    t.decimal  "height",                        precision: 8,  scale: 2
    t.decimal  "width",                         precision: 8,  scale: 2
    t.decimal  "depth",                         precision: 8,  scale: 2
    t.datetime "deleted_at"
    t.datetime "discontinue_on"
    t.boolean  "is_master",                                              default: false
    t.integer  "product_id",        limit: 4
    t.decimal  "cost_price",                    precision: 10, scale: 2
    t.string   "cost_currency",     limit: 255
    t.integer  "position",          limit: 4
    t.boolean  "track_inventory",                                        default: true
    t.integer  "tax_category_id",   limit: 4
    t.datetime "updated_at"
    t.integer  "stock_items_count", limit: 4,                            default: 0,     null: false
  end

  add_index "spree_variants", ["deleted_at"], name: "index_spree_variants_on_deleted_at", using: :btree
  add_index "spree_variants", ["discontinue_on"], name: "index_spree_variants_on_discontinue_on", using: :btree
  add_index "spree_variants", ["is_master"], name: "index_spree_variants_on_is_master", using: :btree
  add_index "spree_variants", ["position"], name: "index_spree_variants_on_position", using: :btree
  add_index "spree_variants", ["product_id"], name: "index_spree_variants_on_product_id", using: :btree
  add_index "spree_variants", ["sku"], name: "index_spree_variants_on_sku", using: :btree
  add_index "spree_variants", ["tax_category_id"], name: "index_spree_variants_on_tax_category_id", using: :btree
  add_index "spree_variants", ["track_inventory"], name: "index_spree_variants_on_track_inventory", using: :btree

  create_table "spree_zone_members", force: :cascade do |t|
    t.integer  "zoneable_id",   limit: 4
    t.string   "zoneable_type", limit: 255
    t.integer  "zone_id",       limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "spree_zone_members", ["zone_id"], name: "index_spree_zone_members_on_zone_id", using: :btree
  add_index "spree_zone_members", ["zoneable_id", "zoneable_type"], name: "index_spree_zone_members_on_zoneable_id_and_zoneable_type", using: :btree

  create_table "spree_zones", force: :cascade do |t|
    t.string   "name",               limit: 255
    t.string   "description",        limit: 255
    t.boolean  "default_tax",                    default: false
    t.integer  "zone_members_count", limit: 4,   default: 0
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.string   "kind",               limit: 255
  end

  add_index "spree_zones", ["default_tax"], name: "index_spree_zones_on_default_tax", using: :btree
  add_index "spree_zones", ["kind"], name: "index_spree_zones_on_kind", using: :btree

  create_table "time_entries", force: :cascade do |t|
    t.integer  "project_id",  limit: 4,    null: false
    t.integer  "user_id",     limit: 4,    null: false
    t.integer  "issue_id",    limit: 4
    t.float    "hours",       limit: 24,   null: false
    t.string   "comments",    limit: 1024
    t.integer  "activity_id", limit: 4,    null: false
    t.date     "spent_on",                 null: false
    t.integer  "tyear",       limit: 4,    null: false
    t.integer  "tmonth",      limit: 4,    null: false
    t.integer  "tweek",       limit: 4,    null: false
    t.datetime "created_on",               null: false
    t.datetime "updated_on",               null: false
  end

  add_index "time_entries", ["activity_id"], name: "index_time_entries_on_activity_id", using: :btree
  add_index "time_entries", ["created_on"], name: "index_time_entries_on_created_on", using: :btree
  add_index "time_entries", ["issue_id"], name: "time_entries_issue_id", using: :btree
  add_index "time_entries", ["project_id"], name: "time_entries_project_id", using: :btree
  add_index "time_entries", ["user_id"], name: "index_time_entries_on_user_id", using: :btree

  create_table "tokens", force: :cascade do |t|
    t.integer  "user_id",    limit: 4,  default: 0,  null: false
    t.string   "action",     limit: 30, default: "", null: false
    t.string   "value",      limit: 40, default: "", null: false
    t.datetime "created_on",                         null: false
  end

  add_index "tokens", ["user_id"], name: "index_tokens_on_user_id", using: :btree
  add_index "tokens", ["value"], name: "tokens_value", unique: true, using: :btree

  create_table "trackers", force: :cascade do |t|
    t.string  "name",              limit: 30, default: "",    null: false
    t.boolean "is_in_chlog",                  default: false, null: false
    t.integer "position",          limit: 4,  default: 1
    t.boolean "is_in_roadmap",                default: true,  null: false
    t.integer "fields_bits",       limit: 4,  default: 0
    t.integer "default_status_id", limit: 4
  end

  create_table "user_preferences", force: :cascade do |t|
    t.integer "user_id",   limit: 4,     default: 0,     null: false
    t.text    "others",    limit: 65535
    t.boolean "hide_mail",               default: false
    t.string  "time_zone", limit: 255
  end

  add_index "user_preferences", ["user_id"], name: "index_user_preferences_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "login",              limit: 255, default: "",    null: false
    t.string   "hashed_password",    limit: 40,  default: "",    null: false
    t.string   "firstname",          limit: 30,  default: "",    null: false
    t.string   "lastname",           limit: 255, default: "",    null: false
    t.boolean  "admin",                          default: false, null: false
    t.integer  "status",             limit: 4,   default: 1,     null: false
    t.datetime "last_login_on"
    t.string   "language",           limit: 5,   default: ""
    t.integer  "auth_source_id",     limit: 4
    t.datetime "created_on"
    t.datetime "updated_on"
    t.string   "type",               limit: 255
    t.string   "identity_url",       limit: 255
    t.string   "mail_notification",  limit: 255, default: "",    null: false
    t.string   "salt",               limit: 64
    t.boolean  "must_change_passwd",             default: false, null: false
    t.datetime "passwd_changed_on"
  end

  add_index "users", ["auth_source_id"], name: "index_users_on_auth_source_id", using: :btree
  add_index "users", ["id", "type"], name: "index_users_on_id_and_type", using: :btree
  add_index "users", ["type"], name: "index_users_on_type", using: :btree

  create_table "versions", force: :cascade do |t|
    t.integer  "project_id",      limit: 4,   default: 0,      null: false
    t.string   "name",            limit: 255, default: "",     null: false
    t.string   "description",     limit: 255, default: ""
    t.date     "effective_date"
    t.datetime "created_on"
    t.datetime "updated_on"
    t.string   "wiki_page_title", limit: 255
    t.string   "status",          limit: 255, default: "open"
    t.string   "sharing",         limit: 255, default: "none", null: false
  end

  add_index "versions", ["project_id"], name: "versions_project_id", using: :btree
  add_index "versions", ["sharing"], name: "index_versions_on_sharing", using: :btree

  create_table "watchers", force: :cascade do |t|
    t.string  "watchable_type", limit: 255, default: "", null: false
    t.integer "watchable_id",   limit: 4,   default: 0,  null: false
    t.integer "user_id",        limit: 4
  end

  add_index "watchers", ["user_id", "watchable_type"], name: "watchers_user_id_type", using: :btree
  add_index "watchers", ["user_id"], name: "index_watchers_on_user_id", using: :btree
  add_index "watchers", ["watchable_id", "watchable_type"], name: "index_watchers_on_watchable_id_and_watchable_type", using: :btree

  create_table "wiki_content_versions", force: :cascade do |t|
    t.integer  "wiki_content_id", limit: 4,                       null: false
    t.integer  "page_id",         limit: 4,                       null: false
    t.integer  "author_id",       limit: 4
    t.binary   "data",            limit: 4294967295
    t.string   "compression",     limit: 6,          default: ""
    t.string   "comments",        limit: 1024,       default: ""
    t.datetime "updated_on",                                      null: false
    t.integer  "version",         limit: 4,                       null: false
  end

  add_index "wiki_content_versions", ["updated_on"], name: "index_wiki_content_versions_on_updated_on", using: :btree
  add_index "wiki_content_versions", ["wiki_content_id"], name: "wiki_content_versions_wcid", using: :btree

  create_table "wiki_contents", force: :cascade do |t|
    t.integer  "page_id",    limit: 4,                       null: false
    t.integer  "author_id",  limit: 4
    t.text     "text",       limit: 4294967295
    t.string   "comments",   limit: 1024,       default: ""
    t.datetime "updated_on",                                 null: false
    t.integer  "version",    limit: 4,                       null: false
  end

  add_index "wiki_contents", ["author_id"], name: "index_wiki_contents_on_author_id", using: :btree
  add_index "wiki_contents", ["page_id"], name: "wiki_contents_page_id", using: :btree

  create_table "wiki_pages", force: :cascade do |t|
    t.integer  "wiki_id",    limit: 4,                   null: false
    t.string   "title",      limit: 255,                 null: false
    t.datetime "created_on",                             null: false
    t.boolean  "protected",              default: false, null: false
    t.integer  "parent_id",  limit: 4
  end

  add_index "wiki_pages", ["parent_id"], name: "index_wiki_pages_on_parent_id", using: :btree
  add_index "wiki_pages", ["wiki_id", "title"], name: "wiki_pages_wiki_id_title", using: :btree
  add_index "wiki_pages", ["wiki_id"], name: "index_wiki_pages_on_wiki_id", using: :btree

  create_table "wiki_redirects", force: :cascade do |t|
    t.integer  "wiki_id",              limit: 4,   null: false
    t.string   "title",                limit: 255
    t.string   "redirects_to",         limit: 255
    t.datetime "created_on",                       null: false
    t.integer  "redirects_to_wiki_id", limit: 4,   null: false
  end

  add_index "wiki_redirects", ["wiki_id", "title"], name: "wiki_redirects_wiki_id_title", using: :btree
  add_index "wiki_redirects", ["wiki_id"], name: "index_wiki_redirects_on_wiki_id", using: :btree

  create_table "wikis", force: :cascade do |t|
    t.integer "project_id", limit: 4,               null: false
    t.string  "start_page", limit: 255,             null: false
    t.integer "status",     limit: 4,   default: 1, null: false
  end

  add_index "wikis", ["project_id"], name: "wikis_project_id", using: :btree

  create_table "workflows", force: :cascade do |t|
    t.integer "tracker_id",    limit: 4,  default: 0,     null: false
    t.integer "old_status_id", limit: 4,  default: 0,     null: false
    t.integer "new_status_id", limit: 4,  default: 0,     null: false
    t.integer "role_id",       limit: 4,  default: 0,     null: false
    t.boolean "assignee",                 default: false, null: false
    t.boolean "author",                   default: false, null: false
    t.string  "type",          limit: 30
    t.string  "field_name",    limit: 30
    t.string  "rule",          limit: 30
  end

  add_index "workflows", ["new_status_id"], name: "index_workflows_on_new_status_id", using: :btree
  add_index "workflows", ["old_status_id"], name: "index_workflows_on_old_status_id", using: :btree
  add_index "workflows", ["role_id", "tracker_id", "old_status_id"], name: "wkfs_role_tracker_old_status", using: :btree
  add_index "workflows", ["role_id"], name: "index_workflows_on_role_id", using: :btree

end
