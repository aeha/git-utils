require "optparse"
require "ostruct"
require "time"
require "net/smtp"
require "socket"
require "nkf"
  KILO_SIZE = 1000
  DEFAULT_MAX_SIZE = "100M"


       @reference.sub(/\A.*\/.*\//,'');
    attr_reader :old_revision, :new_revision, :reference, :ref_type, :log
    attr_reader :author, :author_email, :date, :subject, :change_type
    def initialize(old_revision, new_revision, reference,
                   ref_type, change_type, log)
      @ref_type = ref_type
      @author_email = get_record("%an <%ae>")
        "X-Git-Reftype: #{ref_type}" ]
    CHANGE_TYPE = {
      :create => "created",
      :update => "updated",
      :delete => "deleted",
    }
      attr_reader :old_revision, :new_revision, :a, :b
      attr_reader :added_line, :deleted_line, :body, :type
      attr_reader :deleted_file_mode, :new_file_mode, :old_mode, :new_mode
      attr_reader :similarity_index
      def mode_changed?
        @is_mode_changed
      end

        @is_mode_changed = false

          when /\Anew file mode (.*)\Z/
            @type = :added
            @new_file_mode = $1
          when /\Adeleted file mode (.*)\Z/
            @deleted_file_mode = $1
          when /\Aindex ([0-9a-f]{7})\.\.([0-9a-f]{7})/
            @old_blob = $1
            @new_blob = $2
          when /\Arename (from|to) (.*)\Z/
            @type = :renamed
          when /\Acopy (from|to) (.*)\Z/
            @type = :copied
          when /\Asimilarity index (.*)\Z/
            @similarity_index = $1
          when /\Aold mode (.*)\Z/
            @old_mode = $1
            @is_mode_changed = true
          when /\Anew mode (.*)\Z/
            @new_mode = $1
            @is_mode_changed = true
            puts "needs to parse: " + line
           "--- #{@a}    #{format_time(@old_date)} (#{@old_revision[0,7]})\n" +
           "+++ #{@b}    #{format_time(@new_date)} (#{@new_revision[0,7]})\n"
           "(Binary files differ)\n"
        @b # the new file entity when copied and renamed
      end

      def link
        file
      end
      
      def file_path
        file
    end

    attr_reader :revision, :author, :date, :subject, :log, :commit_id
    attr_reader :author_email, :diffs, :added_files, :copied_files
    attr_reader :deleted_files, :updated_files, :renamed_files
    def initialize(repository, reference, revision)
      @repository = repository
      @reference = reference
      @revision = revision

      @added_files = []
      @copied_files = []
      @deleted_files = []
      @updated_files = []
      @renamed_files = []
      parse
      parse_diff
      init_file_status

      sub_paths('driver')
    end

    def sub_paths(prefix)
      prefixes = prefix.split(/\/+/)
      results = []
      @diffs.each do |diff|
        paths = diff.file_path.split(/\/+/)
        if prefixes.size < paths.size and prefixes == paths[0, prefixes.size]
          results << paths[prefixes.size]
        end
      results
      f = IO.popen("git log -n 1 --pretty=format:'' -C -p #{@revision}")
      @author_email = get_record("%an <%ae>")
      @subject = get_record("%s")
      `git log -n 1 --pretty=format:'' -C --name-status #{@revision}`.
      lines.each do |l|
        elsif l =~ /\A([^\t]*?)\t([^\t]*?)\t([^\t]*?)\Z/
          status = $1
          from_file = $2
          to_file = $3

          case status
          when /^R/ # Renamed
            @renamed_files << [from_file, to_file]
          when /^C/ # Copied
            @copied_files << [from_file, to_file]
          end
      `git log -n 1 --pretty=format:'#{record}' #{revision}`.strip
      change_type = :update
      change_type = :create
      change_type = :delete
    when :create, :update
      rev_type=`git cat-file -t #@new_revision`.strip
    when :delete
      rev_type=`git cat-file -t #@old_revision`.strip
    if reference =~ /refs\/tags\/(.*)/ and rev_type == "commit"
      short_ref = $1
    elsif reference =~ /refs\/tags\/(.*)/ and rev_type == "tag"
      short_ref = $1
    elsif reference =~ /refs\/heads\/(.*)/ and rev_type == "commit"
      short_ref = $1
      raise "Unknown type of update to #@reference (#{rev_type})"
    msg = if ref_type == "branch" and change_type == :update
            process_update_branch(block)
          elsif ref_type == "branch" and change_type == :create
            process_create_branch(block)
          elsif ref_type == "branch" and change_type == :delete
            process_delete_branch(block)
          elsif ref_type == "annotated tag" and change_type == :update
            process_update_atag
          elsif ref_type == "annotated tag" and change_type == :create
            process_create_atag
          elsif ref_type == "annotated tag" and change_type == :delete
            process_delete_atag
          end
    msg = "Branch (#@reference) is created.\n"
    IO.popen("git rev-parse --not --branches |
              grep -v $(git rev-parse #{reference}) |
              git rev-list --stdin #{new_revision}").
    readlines.reverse.each { |revision|
      subject = GitCommitMailer.get_record(revision,'%s')
      commit_list << "     via  #{revision[0,7]} #{subject}\n"
    if commit_list.length > 0
      subject = GitCommitMailer.get_record(new_revision,'%s')
      commit_list[-1] = "      at  #{new_revision[0,7]} #{subject}\n"
      msg << commit_list.join
    end
    msg = "Branch (#@reference) is updated.\n"
      subject = GitCommitMailer.get_record(revision,'%s')
      revision_list << "discards  #{revision[0,7]} #{subject}\n"
      subject = GitCommitMailer.get_record(revision,'%s')
      revision_list << "     via  #{revision[0,7]} #{subject}\n"
      subject = GitCommitMailer.get_record(old_revision,'%s')
      revision_list << "    from  #{old_revision[0,7]} #{subject}\n"
    IO.popen("git rev-list #{old_revision}..#{new_revision}").
    readlines.reverse.each { |revision|
    "Branch (#@reference) is deleted.\n" +
    "Annotated tag (#@reference) is created.\n" +
    "Annotated tag (#@reference) is updated.\n" +
    "Annotated tag (#@reference) is deleted.\n" +
        msg << `git rev-list --pretty=short \"#{prev_tag}..#@new_revision\" |
                git shortlog`
      @push_info = PushInfo.new(old_revision, new_revision, reference,
                                *push_info_args)
      body << renamed_files
    else
      raise "a new Info Class?"
      rv << files.collect do |from_file, to_file|
    #{to_file}
      (from #{from_file})
  def renamed_files
    changed_files("Renamed", @info.renamed_files) do |rv, files|
      rv << files.collect do |from_file, to_file|
        <<-INFO
    #{to_file}
      (from #{from_file})
INFO
    :renamed => "Renamed",
    diff_info.each do |desc|
      similarity_index = ""
      file_mode = ""
      case diff.type
      when :added
        command = "show"
        file_mode = "Mode: #{diff.new_file_mode}"
      when :deleted
        command = "show"
        file_mode = "Mode: #{diff.deleted_file_mode}"
        rev = diff.old_revision
      when :modified
        command = "diff"
        args.concat(["-r", diff.old_revision[0,7], diff.new_revision[0,7],
                     diff.link])
      when :renamed
        command = "diff"
        args.concat(["-C","--diff-filter=R",
                     "-r", diff.old_revision[0,7], diff.new_revision[0,7], "--",
                     diff.a, diff.b])
        similarity_index = "Similarity: #{diff.similarity_index}"
      when :copied
        command = "diff"
        args.concat(["-C","--diff-filter=C",
                     "-r", diff.old_revision[0,7], diff.new_revision[0,7], "--",
                     diff.a, diff.b])
        similarity_index = "Similarity: #{diff.similarity_index}"
      else
        raise "unknown diff type: #{diff.type}"
      end
      if command == "show"
        args.concat(["#{rev[0,7]}:#{diff.link}"])
      end

      command += " #{args.join(' ')}" unless args.empty?
      desc =  "  #{CHANGED_TYPE[diff.type]}: #{diff.file} (#{line_info})"
      desc << " #{file_mode}#{similarity_index}\n"
      if diff.mode_changed?
        desc << "  Mode: #{diff.old_mode} -> #{diff.new_mode}\n"
      end
      desc << "#{"=" * 67}\n"
    % git #{command}
      desc
    headers << "Subject: #{(@name+' ') if @name}#{make_subject}"
  def detect_project
    project=`sed -ne \'1p\' \"#{ENV['GIT_DIR']}/description\"`.strip
    # Check if the description is unchanged from it's default, and shorten it to
    # a more manageable length if it is
    if project =~ /Unnamed repository.*$/
      project = nil
    end

    project
  end

  def make_subject
    subject = ""
    project = detect_project
    revision_info = "#{@info.revision[0,7]}"

    if @info.class == CommitInfo
      if show_path?
        _affected_paths = affected_paths
        unless _affected_paths.empty?
          revision_info = "(#{_affected_paths.join(',')}) #{revision_info}"

      if project
        subject << "[commit #{project} #{@info.short_reference} " +
                   "#{revision_info}] "
      else
        subject << "#{revision_info}: "
      end
      subject << @info.subject
    elsif @info.class == PushInfo
      if project
        subject << "[push #{project}] "
      else
        subject << "[push] "
      end
      subject << "#{@info.ref_type} (#{@info.short_reference}) is" +
                 " #{PushInfo::CHANGE_TYPE[@info.change_type]}."
    else
      raise "a new Info class?"

    #NKF.nkf("-WM", subject)
  end

  def affected_paths
    paths = []
    sub_paths = @info.sub_paths('')
    paths.concat(sub_paths)
  if to.empty?