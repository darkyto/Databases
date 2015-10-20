namespace CodeFirst.Models
{
    using System;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;

    public class Homework
    {
        public int Id { get; set; }

        [Required]
        [MaxLength(500)]
        public string Title { get; set; }

        public string Content { get; set; }

        public byte[] Attachments { get; set; }

        public string AttachmentsName { get; set; }

        public string AttachmentsExtension { get; set; }

        public DateTime? TimeSent { get; set; }

        public int CourseId { get; set; }

        public virtual Course Course { get; set; }

        public int StudentId { get; set; }

        [ForeignKey("StudentId")]
        public virtual Student Student { get; set; }
    }
}
