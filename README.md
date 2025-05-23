# ケイゾク - 学習の継続を可視化し、モチベーションを向上させる学習記録アプリ

## 1. サービス概要

**「続ける」を見える化し、学習の習慣化をサポートする学習記録アプリ**

## 2. サービス画像

![keizokuapp](https://github.com/user-attachments/assets/6d53f95d-d743-4922-8d92-64e5248026d2)

## 3. サービスのURL

[https://keizoku-app.herokuapp.com/](https://keizoku-study-logger-6aa7dda15d0f.herokuapp.com/home/index)

## 4. サービスの概要

「ケイゾク」は、日々の学習活動を簡単に記録・可視化できるウェブアプリです。学習の継続をサポートし、自分の進捗を視覚的に確認することができます。カレンダー形式で学習時間を色の濃さで表現し、学習の「継続」を一目で確認できるのが特徴です。

## 5. 開発背景

社会人向けの学習管理アプリがないと感じたのが一番のきっかけでした。学生ではStudyPlusがありますが、社会人がモチベーションを上げられる仕組みが欲しいと考えました。

GitHubのコントリビューショングラフのように、学習の頻度や量を視覚的に表現できれば、自己肯定感を高め、継続する原動力になると考え、このアプリを開発しました。

既存の学習記録アプリもありますが、シンプルさと視覚的なフィードバックを重視したアプリを作りたいと思いました。

## 6. 機能

### ホーム画面
- **カレンダービュー**: 月間カレンダーで学習時間を色の濃さで表示
- **学習記録フォーム**: 学習内容（科目、時間、メモ）を入力して記録
- **学習記録リスト**: 過去の学習記録を一覧表示

### 日付詳細モーダル
- その日の学習記録の詳細表示
- 合計学習時間の確認
- その日の学習セッションの追加・編集(削除機能は今後実装)

### 科目管理
- オリジナルの学習科目を追加
- 科目ごとに色を設定
- 科目の編集(削除機能は今後実装)

## 7. 主な使用技術

### フロントエンド
- HTML / CSS / JavaScript
- Tailwind CSS（スタイリング）
- Hotwire（Turbo、Stimulus）（インタラクティブUI）

### バックエンド
- Ruby 3.1.6
- Ruby on Rails 7.1.5
- PostgreSQL（データベース）

### インフラ・開発環境
- Heroku（デプロイ）
- Git / GitHub（バージョン管理）

## 8. ER図

現在ユーザー認証機能を搭載させていない為、学習科目と学習記録の2つのデータベースで構築しています。
今後ユーザーデータベースを搭載し、ユーザーが実際に利用できるフェイズに移行予定です。

```
┌───────────────────┐       ┌───────────────────┐
│   StudySubject    │       │   StudySession    │
├───────────────────┤       ├───────────────────┤
│ id: integer       │       │ id: integer       │
│ name: string      │╲      │ date: date        │
│ color: string     │──┼────┤ duration: integer │
│ created_at: time  │╱      │ notes: text       │
│ updated_at: time  │       │ study_subject_id  │
└───────────────────┘       │ created_at: time  │
                            │ updated_at: time  │
                            └───────────────────┘
```

## 9. 今後の展望
### 直近の修正予定
- CRUD処理の一部実装
- テスト実装
- UI修正
- レスポンシブ対応

### 短期的な目標
- ユーザー認証機能の追加
- 統計・分析機能の強化（週間・月間レポートなど）
- データのエクスポート機能

### 中長期的な目標

- 学習目標設定と達成度管理機能
- 友人とのシェア機能の追加
